//
//  MessageViewController.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/19/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase



class MessageViewController: JSQMessagesViewController {
    
    // MARK: Constants
    
    
    
    // MARK: Properties
    
    var messages = [JSQMessage]()
    var avatars = [JSQMessage]()
    var outgoingMessage: JSQMessagesBubbleImage?
    var incomingMessage: JSQMessagesBubbleImage?
    var outgoingAvatarImage: JSQMessagesAvatarImage?
    var incomingAvatarImage: JSQMessagesAvatarImage?
    var messageRef: Firebase?
    var userIsTypingRef: Firebase?
    private var localTyping = false
    var usersTypingQuery: FQuery?
    var user: User?
    
    var isTyping: Bool {
        get {
            return localTyping
        }
        
        set(newMessage) {
            localTyping = newMessage
            userIsTypingRef?.setValue(newMessage)
        }
    }
    
    // MARK: LifeCycle
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Query messages
        observeFirebaseNewMessages()
        observeUserTyping()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMessageBubbles()
        
        // Add key to rootRef
        messageRef = baseURL.childByAppendingPath("messages")
        
    }
    
    // MARK: JSQMessages helper
    
    private func setupMessageBubbles() {
        
        let factory = JSQMessagesBubbleImageFactory()
        
        // Message bubble color
        outgoingMessage = factory.outgoingMessagesBubbleImageWithColor(UIColor.powwowRed())
        incomingMessage = factory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
        
        // Avatar image
        outgoingAvatarImage = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials("", backgroundColor: UIColor.powwowBlue(), textColor: UIColor.whiteColor(), font: UIFont.boldSystemFontOfSize(10), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
        incomingAvatarImage = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials("", backgroundColor: UIColor.powwowGreen(), textColor: UIColor.blackColor(), font: UIFont.boldSystemFontOfSize(10), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
    }
    
    func addMessageToChat(senderId id: String, message text: String) {
        
        let message = JSQMessage(senderId: id, displayName: "", text: text)
        
        messages.append(message)
        
    }
    
    private func observeFirebaseNewMessages() {
        
        // Limit query to last 25 messages
        let messagesQuery = messageRef?.queryLimitedToLast(25)
        
        // Observe for every child item at "messages" key
        messagesQuery?.observeEventType(.ChildAdded) { (snapshot: FDataSnapshot!) in
            
            // Get value of the messages
            let id = snapshot.value["senderId"] as! String
            let message = snapshot.value["message"] as! String
            
            // Add messages to data model
            self.addMessageToChat(senderId: id, message: message)
            
            // Display to user
            self.finishReceivingMessage()
            
        }
    }
    
    private func observeUserTyping() {
        
        // Create child to store user typing
        let typingIndicatorRef = baseURL.childByAppendingPath("typingIndicator")
        
        // Remove on disconnect
        userIsTypingRef = typingIndicatorRef.childByAppendingPath(senderId)
        userIsTypingRef?.onDisconnectRemoveValue()
        
        // Get all users typing
        usersTypingQuery = typingIndicatorRef.queryOrderedByValue().queryEqualToValue(true)
        
        // Observe typingIndicator for changes
        usersTypingQuery?.observeEventType(.Value) { (data: FDataSnapshot!) in
            
            // Dont display if local user is typing
            if data.childrenCount == 1 && self.isTyping  {
                return
            }
            
            // Display chat indicator
            self.showTypingIndicator = data.childrenCount > 0
            self.scrollToBottomAnimated(true)
            
        }
        
    }
    
    // MARK: JSQMessage Delegate
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        
        return messages[indexPath.item]
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
        
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            return outgoingMessage
        } else {
            return incomingMessage
        }
        
    }
    
    // TODO: Add Image support
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        let avatarImage = messages[indexPath.row]
        
        if avatarImage.senderId == senderId {
            return outgoingAvatarImage
        } else {
            return incomingAvatarImage
        }
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        
        // Text color
        if message.senderId == senderId {
            cell.textView?.textColor = UIColor.whiteColor()
        } else {
            cell.textView?.textColor = UIColor.blackColor()
        }
        
        return cell
        
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
        // Create a unique key
        let itemRef = messageRef?.childByAutoId()
        
        // Firebase structure
        let messageItem = [
            "message": text,
            "senderId": senderId
        ]
        
        // Set Firebase key / value
        itemRef?.setValue(messageItem)
        
        // Add sound and animation to chat
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        finishSendingMessage()
        
        // Message sent
        isTyping = false
        
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
       let alert = SweetAlert()
        alert.showAlert("Not supported!")
    }
    
    override func textViewDidChange(textView: UITextView) {
        super.textViewDidChange(textView)
        
        // check if the user is typing
        isTyping = textView.text != ""
        
    }
    
    
}

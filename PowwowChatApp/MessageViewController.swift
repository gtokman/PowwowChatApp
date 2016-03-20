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
    
    let firebaseRef = Firebase(url: "https://powwowchat.firebaseio.com")
    
    // MARK: Properties
    
    var messages = [JSQMessage]()
    var outgoingMessage: JSQMessagesBubbleImage?
    var incomingMessage: JSQMessagesBubbleImage?
    var messageRef: Firebase?
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupMessageBubbles()
        
        // Message avatars
        collectionView?.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView?.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
        // Add key to rootRef
        messageRef = firebaseRef.childByAppendingPath("messages")
        
    }
    
    
    // MARK: JSQMessages helper
    
    private func setupMessageBubbles() {
        
        let factory = JSQMessagesBubbleImageFactory()
        
        // Message bubble color
        outgoingMessage = factory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
        incomingMessage = factory.incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
        
    }
    
    func addMessageToChat(senderId id: String, message text: String) {
        
        let message = JSQMessage(senderId: id, displayName: "", text: text)
        
        messages.append(message)
        
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
        
        return nil
    
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
        
    }

    
}

//
//  LoginViewControllerExtension.swift
//  PowwowChatApp
//
//  Created by g tokman on 3/13/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

extension LoginViewController: UITextFieldDelegate {
    
    // MARK: Keyboard cycle
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        appDescriptionLabel?.hidden = true
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().height {
            
            guard let bottomConstraint = bottomConstraint else {
                print("Could not find bottom constraint!")
                return
            }
            
            bottomConstraint.constant = keyboardSize
        }
        
        UIView.animateWithDuration(0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
       
        userNameTextField!.resignFirstResponder()
        passwordTextField!.becomeFirstResponder()
        
        return true
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        appDescriptionLabel?.hidden = false
        
        let bottomConstraintStart: CGFloat = 51
        
        guard let bottomConstraint = bottomConstraint else {
            print("Could not find bottom constraint!")
            return
        }
        
        bottomConstraint.constant = bottomConstraintStart
        
        UIView.animateWithDuration(0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
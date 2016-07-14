//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var textFields: [UITextField] = []

    // MARK: Functions
    
    func validateField(textField: UITextField) -> Bool {
        if (textField == emailTextField) {
            if (!(emailTextField.text!.containsString("@") && emailTextField.text!.containsString("."))) {
                shakeField(emailTextField)
            }
            
        } else if (textField == emailConfirmationTextField) {
            if (emailConfirmationTextField.text != emailTextField.text) {
                shakeField(emailConfirmationTextField)
            }
            
        } else if (textField == phoneTextField) {
            if (phoneTextField.text?.characters.count < 7) {
                shakeField(phoneTextField)
            }
            
        } else if (textField == passwordTextField) {
            if (passwordTextField.text?.characters.count < 6) {
                shakeField(passwordTextField)
            }
            
        } else if (textField == passwordConfirmTextField) {
            if (passwordConfirmTextField.text != passwordTextField.text) {
                shakeField(passwordConfirmTextField)
            }
        }
        
        return false
    }
    
    func setupConstraints() {
        view.removeConstraints(view.constraints)
        
        emailTextField.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 100).active = true
        emailTextField.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 40).active = true
        emailTextField.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -40).active = true
        
        emailConfirmationTextField.topAnchor.constraintEqualToAnchor(emailTextField.bottomAnchor, constant: 20).active = true
        emailConfirmationTextField.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 40).active = true
        emailConfirmationTextField.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -40).active = true
        
        phoneTextField.topAnchor.constraintEqualToAnchor(emailConfirmationTextField.bottomAnchor, constant: 20).active = true
        phoneTextField.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 40).active = true
        phoneTextField.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -40).active = true
        
        passwordTextField.topAnchor.constraintEqualToAnchor(phoneTextField.bottomAnchor, constant: 20).active = true
        passwordTextField.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 40).active = true
        passwordTextField.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -40).active = true
        
        passwordConfirmTextField.topAnchor.constraintEqualToAnchor(passwordTextField.bottomAnchor, constant: 20).active = true
        passwordConfirmTextField.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 40).active = true
        passwordConfirmTextField.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -40).active = true
        
        submitButton.topAnchor.constraintEqualToAnchor(passwordConfirmTextField.bottomAnchor, constant: 20).active = true
        submitButton.leftAnchor.constraintEqualToAnchor(view.leftAnchor, constant: 40).active = true
        submitButton.rightAnchor.constraintEqualToAnchor(view.rightAnchor, constant: -40).active = true
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(textField: UITextField) {
        validateField(textField)
        
        var valid = true
        for field in textFields {
            if (field.text == "") {
                valid = false
            }
        }
        
        if (valid) {
            submitButton.enabled = true
        }
    }
    
    func shakeField(textField: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(textField.center.x - 10, textField.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(textField.center.x + 10, textField.center.y))
        textField.layer.addAnimation(animation, forKey: "position")
        
        textField.layer.masksToBounds = false
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.redColor().CGColor
    }
    
    // MARK: View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        
        textFields = [emailTextField, emailConfirmationTextField, phoneTextField, passwordTextField, passwordConfirmTextField]
        emailTextField.becomeFirstResponder()
        
        self.submitButton.enabled = false
    }
}
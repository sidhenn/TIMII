//
//  LoginScreen.swift
//  TIMII
//
//  Created by Dennis Huang on 7/27/18.
//  Copyright © 2018 Autonomii. All rights reserved.
//

import UIKit
import Firebase
import Layout

class LoginScreen: UIViewController, LayoutLoading, UITextFieldDelegate
{
    // TODO: 7.30.18 - refactor keyboard related code to a separate component/system
    var isKeyboardVisible = false
    
    // Login Properties
    @IBOutlet var emailTextField : UITextField?
    @IBOutlet var passwordTextField : UITextField?
    @IBOutlet var errorLabel : UILabel?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
        
        // 7.30.18 - Temporary code for testing XML views. Works.
//        let email = UITextField()     // replaces emailTextField?.text
//        let password = UITextField()  // replaces passwordTextField?.text
//        email.text = "ellie@eaton.com"
//        password.text = "12345"
        
        self.loadLayout(
            named: "LoginScreen.xml",
            state:[
                "isKeyboardVisible": isKeyboardVisible,
                "email": emailTextField?.text as Any,
                "password": passwordTextField?.text as Any,
                "error": errorLabel?.text as Any
            ]
        )
    }
    
    @objc func createAccountScreen()
    {
        let createAccount = CreateAccountScreen()
        present(createAccount, animated: true, completion: nil)
    }
    
    // Dismiss the keyboard after RETURN press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return false
    }
    
    @objc func keyboardWillShow(notification: Notification)
    {
        isKeyboardVisible = true
        updateView()
    }
    
    @objc func keyboardWillHide(notification: Notification)
    {
        isKeyboardVisible = false
        updateView()
    }

    // Update screen when varibles change
    private func updateView()
    {
        // Calling setState() on a LayoutNode after it has been created will
        // trigger an update. The update causes all expressions in that node
        // and its children to be re-evaluated.
        self.layoutNode?.setState([
            "isKeyboardVisible": isKeyboardVisible,
            "error": errorLabel?.text as Any
        ])
    }
    
    // Handle login request and authentication with Firebase
    @objc func handleLogin() {
        guard let email = emailTextField?.text, let password = passwordTextField?.text else
        {
            print("Form is not valid. Unable to login.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion:
        {(user, error) in
            if error != nil
            {
                print(error ?? "Error signing in user.")
                self.errorLabel?.text = error?.localizedDescription
                self.updateView()
                return
            }
            // Dismiss to Main screen
            print("Sign in successful.")
            self.dismiss(animated: true, completion: nil)
        })
    }
}
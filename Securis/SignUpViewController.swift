//
//  SignUpViewController.swift
//  Securis
//
//  Created by Derek Roberts on 3/7/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    
    // Firebase database reference
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addHorizontalGradientLayer(leftColor: primaryColor, rightColor: secondaryColor)
        
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        usernameField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case usernameField:
            usernameField.resignFirstResponder()
            emailField.becomeFirstResponder()
            break
        case emailField:
            emailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
            break
        case passwordField:
            handleSignUp()
            break
        default:
            break
        }
        return true
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        let formFilled = username != nil && username != "" && email != nil && email != "" && password != nil && password != ""
    }
    
    @objc func handleSignUp() {
        guard let username = usernameField.text else {return}
        guard let email = emailField.text else {return}
        guard let pass = passwordField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                print("New user created!")
                
                // Add the username to the currentUser
                let changeReq = Auth.auth().currentUser?.createProfileChangeRequest()
                changeReq?.displayName = username
                changeReq?.commitChanges { error in
                    if error == nil {
                        print("User display name has been changed!")
                        
                        // Add the user to the User section of the realtime database
                        self.saveProfile(username: username, email: email) { success in
                            if success {
                                self.dismiss(animated: false, completion: nil)
                            }
                        }
                    } else {
                        print("Error: \(error!.localizedDescription)")
                    }
                }
                
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
    
    func saveProfile(username:String, email: String, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/\(uid)")
        
        let userObject = [
            "username": username,
            "email": email,
            ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
    
}

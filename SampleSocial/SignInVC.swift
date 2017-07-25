//
//  SignInVC.swift
//  SampleSocial
//
//  Created by Aaron Billings on 7/12/17.
//  Copyright © 2017 Aaron Billings. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: CustomTextField!

    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidAppear(_ animated: Bool) { // Segues should always be in view did appear!!!
        
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }

  
    @IBAction func facebookBtnPressed(_ sender: UIButton) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in // Auth with FB method
            if error != nil {
                self.notifyUser("Error with Facebook Login", message: "Unable to authenticate with facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                self.notifyUser("Authentication Canceled", message: "Facebook Authentication has been canceled")
            } else {
                self.notifyUser("Authentication Successful", message: "Facebook Authentication is successful")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuthenticate(credential)
            }
        }
    }
    
    func notifyUser(_ title: String, message: String) -> Void
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

    func firebaseAuthenticate(_ credential: AuthCredential) { // Auth with Firebase function
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                self.notifyUser("Email Authentication", message: "Unable to authenticate email - \(String(describing: error))")
            } else {
                self.notifyUser("Email Authentication", message: "Successfully authenticated with email")
                
                if let user = user {
                    let userData = ["provider": credential.provider]
                   self.completeSignIn(id: user.uid, userData: userData)
                }
                
            }
        }
    }

    @IBAction func signInBtnPressed(_ sender: Any) {
        
        if let email = emailTextField.text, let pwd = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("Successfully Auth with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("AARON: Unable to Auth with Firebase using email")
                        } else {
                            print("Successfully Auth with Firebase email")
                            
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                 self.completeSignIn(id: user.uid, userData: userData)
                            }
                           
                        } 
                    })
                }
            })
        }
       
        
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        
        
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("AARON: Data saved to keychain")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    @IBAction func resetPwdBtnPressed(_ sender: Any) {
     
        performSegue(withIdentifier: "goToResetPassword", sender: nil)
    }
}


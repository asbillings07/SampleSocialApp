//
//  ResetPasswordVC.swift
//  SampleSocial
//
//  Created by Aaron Billings on 7/19/17.
//  Copyright © 2017 Aaron Billings. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class ResetPasswordVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailResetTextField: UITextField!
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        self.emailResetTextField.delegate = self
        
        
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

    @IBAction func submitPwResetPressed(_ sender: Any) {
        
        if let email = emailResetTextField.text   {
            
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
            self.notifyUser("Password Reset Successful", message: "Password Successfully Sent, Please check your email")
            } else {
                self.notifyUser("Password Reset Unsuccesful", message: "Password Reset email was not sent due to \(String(describing: error))"
            )}
            }
        }
        
        
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
  
}

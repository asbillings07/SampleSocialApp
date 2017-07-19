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
    
    @IBOutlet weak var successfulPwResetLbl: UILabel!
    
    @IBOutlet weak var unsuccessfulPwResetLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
     successfulPwResetLbl.isHidden = true
    unsuccessfulPwResetLbl.isHidden = true
        self.emailResetTextField.delegate = self
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

    @IBAction func submitPwResetPressed(_ sender: Any) {
        
        if let email = emailResetTextField.text   {
            
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
            self.successfulPwResetLbl.isHidden = false
            } else {
                self.unsuccessfulPwResetLbl.text = "Password Reset email was not sent due to \(String(describing: error))"
            }
            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
        }
        
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
  
}

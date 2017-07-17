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

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func facebookBtnPressed(_ sender: UIButton) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in // Auth with FB method
            if error != nil {
                print("AARON: Unable to authenticate with facebook - \(error)")
            } else if result?.isCancelled == true {
                print("AARON: User Canceled FB authentication")
            } else {
                print("AARON: Successfully authenticated with FB")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuthenticate(credential)
            }
        }
    }

    func firebaseAuthenticate(_ credential: AuthCredential) { // Auth with Firebase function
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("Unable to auth with Firebase - \(error)")
            } else {
                print("Successfully auth with Firebase")
            }
        }
    }

}


//
//  FeedVC.swift
//  SampleSocial
//
//  Created by Aaron Billings on 7/19/17.
//  Copyright © 2017 Aaron Billings. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
 

  
 
    @IBAction func logOutPressed(_ sender: Any) {
        
        let keychainResult =  KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("AARON: ID removed from Keychain \(keychainResult)")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        performSegue(withIdentifier: "goToSignIn", sender: nil)
      
    }

}

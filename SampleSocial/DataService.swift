//
//  DataService.swift
//  SampleSocial
//
//  Created by Aaron Billings on 7/20/17.
//  Copyright © 2017 Aaron Billings. All rights reserved.
//

import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = Database.database().reference() // contains root of your database
let STORAGE_BASE = Storage.storage().reference()

class DataService {
    
    static let ds = DataService() // Creates a single instance that you can ref in all VCs
    
    // DB References
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
  
    
    // Storage Refences
    
    private var _REF_POST_IMGS = STORAGE_BASE.child("post-pics")
    private var _REF_PROFILE_IMGS = STORAGE_BASE.child("profile-pics")
    
    
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_USERS_CURRENT: DatabaseReference {
        
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    var REF_POST_IMGS: StorageReference {
        return _REF_POST_IMGS
    }
    
    var REF_PROFILE_IMGS: StorageReference {
        return _REF_PROFILE_IMGS
    }
    
  
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

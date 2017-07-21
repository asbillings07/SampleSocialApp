//
//  Profile.swift
//  SampleSocial
//
//  Created by Aaron Billings on 7/21/17.
//  Copyright © 2017 Aaron Billings. All rights reserved.
//

import Foundation


class Profile {
    
    private var _profileImageUrl: String!
    private var _username: String!
    private var _profileKey: String!
    
    
    var profileImageUrl: String {
        return _profileImageUrl
    }
    
    var username: String {
        return _username
    }
    
    var profileKey: String {
        return _profileKey
    }
    
    
    init(profileImageUrl: String, username: String) {
        
        self._profileImageUrl = profileImageUrl
        self._username = username
    }
    
    init(profileKey: String, profileData: Dictionary<String, AnyObject>) {
        
        self._profileKey = profileKey
        
        if let username = profileData["username"] as? String {
            self._username = username
        }
        
        if let profileImageUrl = profileData["profileImageUrl"] as? String {
            self._profileImageUrl = profileImageUrl
        }
        
       

    }
    
}

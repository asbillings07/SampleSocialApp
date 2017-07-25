//
//  ProfileVC.swift
//  SampleSocial
//
//  Created by Aaron Billings on 7/24/17.
//  Copyright © 2017 Aaron Billings. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class ProfileVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var usernameLbl: UILabel!

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImage: CircleImageView!

    @IBOutlet weak var changePhoneNumberTextField: CustomTextField!
    @IBOutlet weak var changeEmailTextField: CustomTextField!
    @IBOutlet weak var changeUsernameTextfield: CustomTextField!
    
    var imagePicker: UIImagePickerController!
    var imageSelected = false
    var profiles = [Profile]()
    var profile: Profile!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        
        showProfileData()
     
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            profileImage.image = image
            imageSelected = true
        } else {
            print("AARON: A Valid Image was not selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

    func showProfileData() {
 
        DataService.ds.REF_USERS_CURRENT.observe(.value, with: { (snapshot) in
            
                //for snap in snapshot {
                  //  print("Profile Snap: \(sn
                
            if let profileDict = snapshot.value as? NSDictionary {
  
                   let username = profileDict["username"] as? String
                   
                    let emailAddress = profileDict["emailAddress"] as? String
                
                   let phoneNumber = profileDict["phoneNumber"] as? String
                
                   let name = profileDict["name"] as? String
            
            print("\(username)\(emailAddress)\(phoneNumber)\(name)")
                    
                    self.emailLbl.text = emailAddress
                    self.phoneNumberLbl.text = phoneNumber
                    self.usernameLbl.text = username
                    self.nameLbl.text = name
            
            }
                    
                    
                }
            )}
            
    

    func uploadNewProfilePic(proImageUrl: String) {
        
        let profilePicture: Dictionary<String, AnyObject> = [ "profileImageUrl": proImageUrl as AnyObject]
        
        _ = DataService.ds.REF_USERS.setValue(profilePicture)
    }
  
    
    func uploadOrChangeProfileData() {
        
        
        let profile: Dictionary<String, AnyObject> =
            
            ["emailAddress": changeEmailTextField.text as AnyObject,
            
            "phoneNumber": changePhoneNumberTextField.text as AnyObject,
            
            "username": changeUsernameTextfield.text as AnyObject,
            
            
            
        
        
        ]
        
        let fireBaseProfilePost = DataService.ds.REF_USERS.childByAutoId()
        fireBaseProfilePost.setValue(profile)
        
      changeUsernameTextfield.text = ""
      changePhoneNumberTextField.text = ""
      changeEmailTextField.text = ""
        
      
    }

   
    @IBAction func profilePicTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
        
         let img = profileImage.image
        
        if let imageData = UIImageJPEGRepresentation(img!, 0.2) {
            
            let imgUID = NSUUID().uuidString
            let metaData = StorageMetadata()
            metaData.contentType = "image/Jpeg"
            
            DataService.ds.REF_PROFILE_IMGS.child(imgUID).putData(imageData, metadata: metaData, completion: { (metaData, error) in
                
                if error != nil {
                    print("Unable to Upload Image to Firebase")
                } else {
                    print("AARON: Successfully uploaded image to Firebase")
                    let downloadUrl = metaData?.downloadURL()?.absoluteString
                    self.uploadNewProfilePic(proImageUrl: downloadUrl!)
                }
            })
            
        }
    
    }



    @IBAction func backToFeedBtnPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func submitNewProfileInfo(_ sender: Any) {
        
        
        uploadOrChangeProfileData()
    
        
    }

}

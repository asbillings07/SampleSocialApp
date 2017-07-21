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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var addImage: CircleImageView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addCaptionTextField: UITextField!
    

  
    
    var posts = [Post]()

    var imagePicker: UIImagePickerController!
    var imageSelected = false
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.addCaptionTextField.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    print("SNAP:\(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
                
            }
            self.tableView.reloadData()
        })
        
      
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
            
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            
        } else {
            cell.configureCell(post: post, img: nil)
            
            
            }
            return cell
            
        }
        return PostCell()
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImage.image = img
            imageSelected = true
            
        } else {
            print("AARON: A valid image was not selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
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
    @IBAction func addImageTapped(_ sender: Any) {
      
         present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func postBtnPressed(_ sender: Any) {
        
        guard let caption = addCaptionTextField.text, caption != "" else {
            print("AARON: Caption Must be entered")
            return
        }
        guard let img = addImage.image, imageSelected == true else {
            print("AARON: An Image Must be Selected")
            return
        }
        if let imageData = UIImageJPEGRepresentation(img, 0.2) {
            
            let imgUID = NSUUID().uuidString
            let metaData = StorageMetadata()
            metaData.contentType = "image/Jpeg"
            
            DataService.ds.REF_POST_IMGS.child(imgUID).putData(imageData, metadata: metaData) { (metaData, error) in
                
                if error != nil {
                    print("AARON: Unable to upload image to firebase")
                } else {
                    print("AARON: Successfully Uploaded image to Firebase Storage")
                    let downloadUrl = metaData?.downloadURL()?.absoluteString
                    if let url = downloadUrl {
                        self.postToFirebase(imgUrl: url)
                    }
                    
                }
            }
            
            
        }
    }
    
    func postToFirebase(imgUrl: String) {
        
        let post: Dictionary<String, AnyObject> = [
        
            "caption": addCaptionTextField.text as AnyObject,
            "imageUrl": imgUrl as AnyObject,
            "likes": 0 as AnyObject
        ]
        let firebasePost = DataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        addCaptionTextField.text = ""
        imageSelected = false
        addImage.image = UIImage(named: "add-image")
        
        tableView.reloadData()
    }

}

//
//  PostCell.swift
//  SampleSocial
//
//  Created by Aaron Billings on 7/20/17.
//  Copyright © 2017 Aaron Billings. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likesImage: UIImageView!
    
    var post: Post!
    var profile: Profile!
    var likesRef: DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        tap.numberOfTapsRequired = 1
        likesImage.addGestureRecognizer(tap)
        likesImage.isUserInteractionEnabled = true
    }
    
    func configureCell(post: Post, img: UIImage? = nil) {
        self.post = post
        likesRef = DataService.ds.REF_USERS_CURRENT.child("likes").child(post.postKey)
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
  //      self.userNameLbl.text = profile.username
        
   //     if profileImg != nil {
    //        self.profileImage.image = profileImg
    //    } else {
    //        let profileRef = Storage.storage().reference(forURL: profile.profileImageUrl)
    //        profileRef.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
     //           if error != nil {
     //               print("AARON: Unable to dwnload PROfile image from Firebase Storage")
     //           } else {
     //               print("AARON: PROfile Img downloaded from Firebase Storage")
     //               if let imageData2 = data {
    //                    if let pImg = UIImage(data: imageData2) {
     //                       self.profileImage.image = pImg
     //                       FeedVC.imageCache.setObject(pImg, forKey: profile.profileImageUrl as NSString)
    //                    }
    //                }
     //           }
     //       })
    //    }
        
        if img != nil {
            self.postImage.image = img
        } else {
                let ref = Storage.storage().reference(forURL: post.imageUrl)
               ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("AARON: Unable to dwnload image from Firebase Storage")
                } else {
                    print("AARON: Img downloade from Firebase Storage")
                    if let imageData = data {
                        if let img = UIImage(data: imageData) {
                            self.postImage.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                }
                
            })
        }
        
        
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likesImage.image = UIImage(named: "empty-heart")
            } else {
                self.likesImage.image = UIImage(named: "filled-heart")
            }
        })
    }
    
    func likeTapped(sender: UITapGestureRecognizer) {
        likesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likesImage.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(addLike: true)
                self.likesRef.setValue(true)
            } else {
                self.likesImage.image = UIImage(named: "empty-heart")
                self.post.adjustLikes(addLike: false)
                self.likesRef.removeValue()
                
    }
    
    
    
    
    
    }

    )}


}

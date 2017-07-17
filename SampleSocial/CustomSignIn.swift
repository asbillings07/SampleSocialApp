//
//  CustomSignIn.swift
//  SampleSocial
//
//  Created by Aaron Billings on 7/17/17.
//  Copyright © 2017 Aaron Billings. All rights reserved.
//

import UIKit

class CustomSignIn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.8
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        layer.cornerRadius = 2.0
    }
}

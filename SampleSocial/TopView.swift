//
//  TopView.swift
//  SampleSocial
//
//  Created by Aaron Billings on 7/13/17.
//  Copyright © 2017 Aaron Billings. All rights reserved.
//

import UIKit

class TopView: UIView {
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: SHADOW_GREY).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
    }
  
}

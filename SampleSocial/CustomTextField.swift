//
//  CustomTextField.swift
//  SampleSocial
//
//  Created by Aaron Billings on 7/17/17.
//  Copyright © 2017 Aaron Billings. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.3).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
    
        }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }

}

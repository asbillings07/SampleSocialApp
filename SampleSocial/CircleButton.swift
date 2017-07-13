//
//  CircleButton.swift
//  SampleSocial
//
//  Created by Aaron Billings on 7/13/17.
//  Copyright © 2017 Aaron Billings. All rights reserved.
//

import UIKit

class CircleButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 50.00 {
        didSet {
            setupView()
        }
    }
    
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
    
    
    
    
    
    
    
    
    
    

    
}

//
//  FacebookImageView.swift
//  SampleSocial
//
//  Created by Aaron Billings on 7/14/17.
//  Copyright © 2017 Aaron Billings. All rights reserved.
//

import UIKit

class FacebookImageView: UIImageView {

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

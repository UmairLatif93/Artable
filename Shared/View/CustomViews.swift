//
//  CustomViews.swift
//  Artable
//
//  Created by Umair Latif on 17/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit

class CustomViews : UIButton {
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}

class RoundedShadowViews : UIView {
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        layer.cornerRadius = 5
        layer.shadowColor = AppColors.Blue.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
}

class RoundedImageViews : UIImageView {
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        layer.cornerRadius = 5
    }
}

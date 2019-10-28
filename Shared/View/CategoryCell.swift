//
//  CategoryCell.swift
//  Artable
//
//  Created by Umair Latif on 17/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryImg: UIImageView!
    @IBOutlet weak var categoryLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categoryImg.layer.cornerRadius = 5
    }

    func ConfigureCell(category : Category){
        
        categoryLbl.text = category.name
        
        if let url = URL(string: category.imgURL) {
            
            let image = UIImage(named: "placeholder")
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
            categoryImg.kf.indicatorType = .activity
            categoryImg.kf.setImage(with: url, placeholder: image, options: options)
        }
    }
}

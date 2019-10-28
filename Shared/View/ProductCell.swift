//
//  ProductCell.swift
//  Artable
//
//  Created by Umair Latif on 18/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit
import Kingfisher

class ProductCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var productImg: RoundedImageViews!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var favouriteBtn: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func ConfigureCell(product : Product){
        
        productTitle.text = product.name
        productPrice.text = "$\(product.price)"
        if let url = URL(string: product.imageUrl) {
            
            productImg.kf.setImage(with: url)
        }
    }
    
    @IBAction func addToCartClicked(_ sender: Any) {
        
        
    }
    
    @IBAction func favouriteClicked(_ sender: Any) {
        
        
    }
}

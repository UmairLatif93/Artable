//
//  ProductDetailVC.swift
//  Artable
//
//  Created by Umair Latif on 28/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit
import Kingfisher

class ProductDetailVC: UIViewController {

    @IBOutlet weak var producImg: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var bgview: UIVisualEffectView!
    
    var product : Product!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        productTitle.text = product.name
        productDescription.text = product.productDescription
        
        if let url = URL(string: product.imageUrl) {
            
            producImg.kf.setImage(with: url)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            
            productPrice.text = price
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissProduct(_:)))
        tap.numberOfTapsRequired = 1
        bgview.addGestureRecognizer(tap)
    }
    
    @objc func dismissProduct(){
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addCartClicked(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissProduct(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
}

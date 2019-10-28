//
//  Product.swift
//  Artable
//
//  Created by Umair Latif on 18/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct Product {
    
    var name : String
    var id : String
    var category : String
    var price : Double
    var productDescription : String
    var imageUrl : String
    var timeStamp : Timestamp
    var stock : Int
    
    init(data: [String : Any]) {
        
        name = data["name"] as? String ?? ""
        id = data["id"] as? String ?? ""
        category = data["category"] as? String ?? ""
        price = data["price"] as? Double ?? 0
        productDescription = data["productDescription"] as? String ?? ""
        imageUrl = data["imageUrl"] as? String ?? ""
        timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
        stock = data["stock"] as? Int ?? 0
    }
}

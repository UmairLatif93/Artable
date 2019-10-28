//
//  Category.swift
//  Artable
//
//  Created by Umair Latif on 17/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Category {
    
    var name : String
    var id : String
    var imgURL : String
    var isActive : Bool = true
    var timeStamp : Timestamp
    
    init(data : [String: Any]) {
        
        self.name = data["name"] as? String ?? ""
        self.id = data["id"] as? String ?? ""
        self.imgURL = data["imgURL"] as? String ?? ""
        self.isActive = data["isActive"] as? Bool ?? true
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
}

//
//  Extension.swift
//  Artable
//
//  Created by Umair Latif on 17/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit
import Firebase

extension String {
    
    var isNotEmpty : Bool {
        
        return !isEmpty
    }
}

extension UIViewController {
    
    func simpleAlert(title : String, msg : String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

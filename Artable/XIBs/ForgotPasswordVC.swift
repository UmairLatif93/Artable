//
//  ForgotPasswordVC.swift
//  Artable
//
//  Created by Umair Latif on 17/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var emailText: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func cancelClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetPasswordClicked(_ sender: Any) {
        
        guard let email = emailText.text , email.isNotEmpty else {
            
            simpleAlert(title: "Error", msg: "Please enter email.")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            
            if let error = error {
                
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}

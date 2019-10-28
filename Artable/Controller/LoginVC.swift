//
//  LoginVC.swift
//  Artable
//
//  Created by Umair Latif on 16/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func LoginClicked(_ sender: Any) {
        
        guard let email = emailText.text , email.isNotEmpty ,
            let password = passwordText.text , password.isNotEmpty else {
            
                simpleAlert(title: "Error", msg: "Please fill out all fields.")
                return
            }
        
        activityIndicator.startAnimating()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                
                print(error)
                self.activityIndicator.stopAnimating()
                Auth.auth().handleFireAuthError(error: error, vc: self)
                return
            }
            
            self.activityIndicator.stopAnimating()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func ForgotPasswordClicked(_ sender: Any) {
        
        let vc = ForgotPasswordVC()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func GuestClicked(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}

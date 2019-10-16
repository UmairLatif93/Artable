//
//  ViewController.swift
//  Artable
//
//  Created by Umair Latif on 16/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        let storyboard = UIStoryboard(name: StoryboardId.LoginStoryboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: StoryboardIdentifier.LoginVC)
        present(controller, animated: true, completion: nil)
    }

}


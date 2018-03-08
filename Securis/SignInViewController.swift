//
//  SignInViewController.swift
//  Securis
//
//  Created by Derek Roberts on 3/7/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addHorizontalGradientLayer(leftColor: primaryColor, rightColor: secondaryColor)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }

}

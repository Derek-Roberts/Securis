//
//  LeaderboardViewController.swift
//  Securis
//
//  Created by Derek Roberts on 4/14/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addHorizontalGradientLayer(leftColor: primaryColor, rightColor: secondaryColor)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

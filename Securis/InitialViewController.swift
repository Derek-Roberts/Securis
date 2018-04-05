//
//  InitialViewController.swift
//  Securis
//
//  Created by Derek Roberts on 3/7/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import Foundation
import UIKit

class InitialViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Todo: Check if user is authenticated. If so, segue to the HomeViewController, otherwise, segue to the MenuViewController
        
        self.performSegue(withIdentifier: "toMenuView", sender: self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }

}

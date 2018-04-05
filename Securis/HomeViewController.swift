//
//  HomeViewController.swift
//  Securis
//
//  Created by Derek Roberts on 3/30/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class HomeViewController:UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logout(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
}

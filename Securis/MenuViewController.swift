//
//  MenuViewController.swift
//  Securis
//
//  Created by Derek Roberts on 3/7/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {

    @IBOutlet weak var signInButton: RoundedButton!
    @IBOutlet weak var signUpButton: RoundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            self.performSegue(withIdentifier: "toHomeView", sender: self)
        }
    }
    
}

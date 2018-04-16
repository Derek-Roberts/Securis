//
//  ProfileViewController.swift
//  Securis
//
//  Created by Derek Roberts on 4/13/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addHorizontalGradientLayer(leftColor: primaryColor, rightColor: secondaryColor)
        
        nameLabel.text = Auth.auth().currentUser?.displayName
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }

}

//
//  QuizResultsViewController.swift
//  Securis
//
//  Created by Derek Roberts on 4/26/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import UIKit
import Firebase

class QuizResultsViewController: UIViewController {
    
    @IBOutlet weak var returnHomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(QuizResultsViewController.goHome))
    }
    
    /*// Used to skip the QuizView and segue to the HomeView
    @objc func goHome(sender: Any) {
        let controller = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 3]
        self.navigationController?.popToViewController(controller!, animated: true)
    }*/
    
    @IBAction func goHome(sender: UIButton) {
        let controller = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 3]
        self.navigationController?.popToViewController(controller!, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

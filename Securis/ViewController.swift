//
//  ViewController.swift
//  Securis
//
//  Created by Derek Roberts on 2/14/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func prepareForUnwind (segue:UIStoryboardSegue) {
        
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        let segue = UnwindSlideSegue(identifier: unwindSegue.identifier, source: unwindSegue.source, destination: unwindSegue.destination)
        segue.perform()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class LoginButton: UIButton {
    override func didMoveToWindow() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}

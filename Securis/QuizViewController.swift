//
//  QuizViewController.swift
//  Securis
//
//  Created by Derek Roberts on 4/9/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import UIKit
import Firebase

class QuizViewController: UIViewController {
    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var scoreCounter: UILabel!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    
    // Button outlets
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    // Quiz ID and title from previous view
    var quizID:Int?
    var quizTitle:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = quizTitle
        
        print("Quiz ID: \(quizID)")
        print("Quiz Title: \(quizTitle)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func optionSelected(_ sender: UIButton) {
        if sender.tag == 1 {
            print("Option 1 Selected")
        } else if sender.tag == 2 {
            print("Option 2 Selected")
        } else if sender.tag == 3 {
            print("Option 3 Selected")
        } else if sender.tag == 4 {
            print("Option 4 Selected")
        } else {
            print("Error: Unknown Option Selected")
        }
        
    }

    
    
}

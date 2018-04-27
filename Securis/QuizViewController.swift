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
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    
    // Button outlets
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    // Quiz ID and title from previous view
    var quizID:Int?
    var category:Category?
    
    var questionNumber: Int = 0
    var score: Int = 0
    var selected: Int = 0
    var totalQuestions: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = category?.name
        self.navigationItem.largeTitleDisplayMode = .never
        totalQuestions = (category?.questions.count)!
        
        updateQuestion()
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func optionSelected(_ sender: UIButton) {
        if sender.tag == selected {
            print("Correct!")
            score += 1
        }
        else {
            print("Incorrect!")
        }
        if questionNumber < totalQuestions {
            updateQuestion()
        }
        else {
            updateUI()
            /*let end = UIAlertController(title: "End", message: "The quiz is over", preferredStyle: .alert)
            present(end, animated: true, completion: nil)*/
            exitQuiz()
        }
    }
    
    func updateQuestion() {
        let currentQuestion = category?.questions[questionNumber]
        questionLabel.text = currentQuestion?.question
        option1.setTitle(currentQuestion?.o1, for: .normal)
        option1.titleLabel?.adjustsFontSizeToFitWidth = true
        option2.setTitle(currentQuestion?.o2, for: .normal)
        option2.titleLabel?.adjustsFontSizeToFitWidth = true
        option3.setTitle(currentQuestion?.o3, for: .normal)
        option3.titleLabel?.adjustsFontSizeToFitWidth = true
        option4.setTitle(currentQuestion?.o4, for: .normal)
        option4.titleLabel?.adjustsFontSizeToFitWidth = true
        selected = (currentQuestion?.answer)!
        
        questionNumber += 1
        updateUI()
    }
    
    func updateUI() {
        let scoreString = "Score: \(score)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: scoreString, style: .plain, target: self, action: nil)
        let progressChunk = (view.frame.size.width / CGFloat(totalQuestions))
        progressBar.frame.size.width += progressChunk
    }
    
    func exitQuiz() {
        self.performSegue(withIdentifier: "toQuizResults", sender: self)
    }
    
    /*func prepareForExit() {
        let exitAlert = UIAlertController(title: "Exit?", message: "Current quiz progress has not been saved. Are you sure you want to leave?", preferredStyle: .alert)
        let exitAction = UIAlertAction(title: "Yes", style: .default, handler: {action in self.exitQuiz()})
        exitAlert.addAction(exitAction)
        present(exitAlert, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        prepareForExit()
    }*/
    
}

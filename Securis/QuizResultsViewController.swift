//
//  QuizResultsViewController.swift
//  Securis
//
//  Created by Derek Roberts on 4/26/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import UIKit
import Firebase

class QuizResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {
    
    @IBOutlet weak var returnHomeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // Quiz category from previous view
    var category:Category?
    
    // UserAnswers from previous view
    var userAnswers = [UserAnswer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set navigationItem.leftBarButtonItem as the title of the previously taken quiz
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: category?.name, style: .plain, target: self, action: #selector(QuizResultsViewController.goHome))
        
        
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(QuizResultsViewController.goHome))
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    /*// Used to skip the QuizView and segue to the HomeView
    @objc func goHome(sender: Any) {
        let controller = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 3]
        self.navigationController?.popToViewController(controller!, animated: true)
    }*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Fix later
        return (category?.questions.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultsTableViewCell
        //let text = category.question.[indexPath.row].name
        //let text = category?.questions[indexPath.row]
        //let questionNumber = category?.questions
        //let text = category?.questions[indexPath.row]
        
        cell.questionNumber.text = "Question " + String(indexPath.row + 1)
        cell.questionText.text = userAnswers[indexPath.row].question
        cell.correctAnswer.text = userAnswers[indexPath.row].answer
        cell.selectedAnswer.text = userAnswers[indexPath.row].chosen
        if userAnswers[indexPath.row].correct == true {
            cell.cellImage.image = #imageLiteral(resourceName: "grin")
        } else {
            cell.cellImage.image = #imageLiteral(resourceName: "sad")
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func goHome(sender: UIButton) {
        let controller = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 3]
        self.navigationController?.popToViewController(controller!, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

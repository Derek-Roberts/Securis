//
//  QuizResultsViewController.swift
//  Securis
//
//  Created by Derek Roberts on 4/26/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class QuizResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {
    
    @IBOutlet weak var returnHomeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // QuizResults object from previous view
    var quizResults = QuizResults()
    
    // Get the Firebase database reference
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set navigationItem.leftBarButtonItem as the title of the previously taken quiz
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: quizResults.quizName, style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: String(quizResults.userAvgCorrect * 100) + "%", style: .plain, target: self, action: nil)
        
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Fix later
        return (quizResults.answers.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultsTableViewCell
        
        cell.questionNumber.text = "Question " + String(indexPath.row + 1)
        cell.questionText.text = quizResults.answers[indexPath.row].question
        cell.correctAnswer.text = quizResults.answers[indexPath.row].answer
        cell.selectedAnswer.text = quizResults.answers[indexPath.row].chosen
        if quizResults.answers[indexPath.row].correct == true {
            cell.cellImage.image = #imageLiteral(resourceName: "grin")
            cell.selectedAnswer.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        } else {
            cell.cellImage.image = #imageLiteral(resourceName: "sad")
            cell.selectedAnswer.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func goHome(sender: UIButton) {
        // Add the user to the User section of the realtime database
        self.saveResults(quizResults: quizResults) { error in
            if error {
                // Need to add an alert that there was an issue saving to the database
                print("Error saving results to database.")
            }
        }
        let controller = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count)! - 3]
        self.navigationController?.popToViewController(controller!, animated: true)
    }
    
    func saveResults(quizResults: QuizResults, completion: @escaping ((_ success:Bool)->())) {
        ref = Database.database().reference()
        guard let uid = Auth.auth().currentUser?.uid else { return }

        // The key does not exist within the database
        let key = ref.child("results").childByAutoId().key
        let questionIDs: [Int] = Array(0...quizResults.answers.count-1)

        // Get the new global average from a func: until then set as zero
        let globalAverage = 0.0
        
        let result = ["quizName": quizResults.quizName,
                    "questionIDS": questionIDs,
                    "globalAverage": globalAverage] as [String : Any]
        let childUpdates = ["/results/\(key)": result,
                            "/user-results/\(uid)/\(key)/": result]
        ref.updateChildValues(childUpdates)
        
        /*let userResultsObject = [
            "quizName": quizResults.quizName,
            ]*/
        
        //databaseRef.setValue(userResultsObject) { error, ref in
        //    completion(error == nil)
        //}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

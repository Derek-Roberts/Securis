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
import FirebaseDatabase

class HomeViewController:UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var leaderboardButton: UIButton!
    
    var ref:DatabaseReference!
    var categories = [Category]()
    
    var testQuestions = [Question]()
    
    var quizID:Int?
    var quizTitle:String?
    var category:Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addHorizontalGradientLayer(leftColor: primaryColor, rightColor: secondaryColor)
        
        
        ref = Database.database().reference()

        ref?.child("courses").observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapData = snapshot.value as? [String:Any] {
                // This will get entire dictionary from Firebase
                if let categoryArray = snapData["categories"] as? [[String:Any]]{
                    for (num, categoryObj) in categoryArray.enumerated() {
                        let name = categoryObj["name"] as? String
                        //print("Category \(num): \(name)")
                        //let key = self.ref.child("questions").childByAutoId().key
                        let newCategory = Category(name: name!, id: num)
                        
                        if let categoryQuestions = categoryObj["questions"] as? [[String:Any]] {
                            for questionObj in categoryQuestions.enumerated() {
                                let q = questionObj.element["question"] as? String
                                let ans = questionObj.element["answer"] as? Int
                                let o1 = questionObj.element["o1"] as? String
                                let o2 = questionObj.element["o2"] as? String
                                let o3 = questionObj.element["o3"] as? String
                                let o4 = questionObj.element["o4"] as? String
                                let newQuestion = Question(question: q!, answer: ans!, o1: o1!, o2: o2!, o3: o3!, o4: o4!)
                                newCategory.addQuestion(question: newQuestion)
                            }
                        }
                        self.categories.append(newCategory)
                        self.tableView.reloadData()
                    }
                }
            }
        })
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")! as! CustomTableViewCell
        let text = categories[indexPath.row].name
        cell.label.text = text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        quizID = indexPath.row
        category = categories[indexPath.row]
        // Shuffle the quiz questions
        category?.shuffleQuestions()
        self.performSegue(withIdentifier: "toQuizView", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toQuizView") {
            let quizViewController = segue.destination as! QuizViewController
            // Pass on the quizID and quizTitle
            quizViewController.quizID = quizID
            //quizViewController.quizTitle = quizTitle
            quizViewController.category = category
        }
    }
    
    @IBAction func goToProfileView(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toProfileView", sender: self)
    }
    
    @IBAction func goToLeaderboardView(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toLeaderboardView", sender: self)
    }

}

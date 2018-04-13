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

/*struct Category {
    let name: String
    let id: Int
    var questions = [Question]()
    
    mutating func addQuestion(question: Question) {
        self.questions.append(question)
    }
    
}*/

struct Question {
    let id: Int
    let question: String
    let answer: Int
    let o1: String
    let o2: String
    let o3: String
    let o4: String
}

class HomeViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref:DatabaseReference?
    var categories = [Category]()
    
    var testQuestions = [Question]()
    
    var quizID:Int?
    var quizTitle:String?
    var category:Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addHorizontalGradientLayer(leftColor: primaryColor, rightColor: secondaryColor)
        
        
        // set the Firebase reference
        ref = Database.database().reference()

        ref?.child("courses").observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapData = snapshot.value as? [String:Any] {
                // This will get entire dictionary from Firebase
                if let categoryArray = snapData["categories"] as? [[String:Any]]{
                    for categoryObj in categoryArray.enumerated() {
                        let name = categoryObj.element["name"] as? String
                        
                        let newCategory = Category(name: name!, id: categoryObj.offset)
                        
                        //var questionsArray = [Question]()
                        
                        if let categoryQuestions = categoryObj.element["questions"] as? [[String:Any]] {
                            //print(categoryQuestions)
                            //print(categoryQuestions?.count)
                            for questionObj in categoryQuestions.enumerated() {
                                let id = questionObj.element["id"] as? Int
                                let q = questionObj.element["question"] as? String
                                let ans = questionObj.element["answer"] as? Int
                                let o1 = questionObj.element["o1"] as? String
                                let o2 = questionObj.element["o2"] as? String
                                let o3 = questionObj.element["o3"] as? String
                                let o4 = questionObj.element["o4"] as? String
                                //questionsArray.append(Question(id: id!, question: question!, answer: answer!, o1: o1!, o2: o2!, o3: o3!, o4: o4!))
                                let newQuestion = Question(id: id!, question: q!, answer: ans!, o1: o1!, o2: o2!, o3: o3!, o4: o4!)
                                newCategory.addQuestion(question: newQuestion)
                            }
                        }
                        
                        //self.categories.append(Category(name: name!, id: categoryObj.offset, questions: questionsArray))
                        self.categories.append(newCategory)
                        self.tableView.reloadData()
                        
                        
                    }
                }
            }
        })
        
        /*ref?.child("courses").observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapData = snapshot.value as? [String:Any] {
                // This will get entire dictionary from Firebase
                if let categoryArray = snapData["categories"] as? [[String:Any]]{
                    for categoryObj in categoryArray.enumerated() {
                        let name = categoryObj.element["name"] as? String
                        self.categories.append(Category(name: name!, id: categoryObj.offset))
                        self.tableView.reloadData()
                    }
                }
            }
        })*/
        
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
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        quizID = indexPath.row
        quizTitle = categories[indexPath.row].name
        self.performSegue(withIdentifier: "toQuizView", sender: self)
    }*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        quizID = indexPath.row
        category = categories[indexPath.row]
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

    @IBAction func quizTest(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toQuizView", sender: self)
    }
    
    @IBAction func logout(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
}

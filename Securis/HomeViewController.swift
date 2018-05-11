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

        /*let quizzesRef = Database.database().reference(withPath: "quizzes")
        var num = 0
        quizzesRef.observe(.childAdded) { snapshot in
            print("The \(snapshot.key) dinosaur's score is \(snapshot.value ?? "null")")
            let sectionSnap = snapshot.value as? [String:Any]
            print("Here is the value for \(snapshot.key): \(String(describing: sectionSnap!["section"]))")
            let newCategory = Category(name: snapshot.key, id: num)
            self.categories.append(newCategory)
            num += 1
            self.tableView.reloadData()
        }*/
        
        
        
        //let children = ref.child("quiz_names")
        
        // Initial setup for the home table, populated from the database
        //ref.child("QuizNames").observeSingleEvent(of: .value, with: { (snapshot) in
            //print("THIS IS A TEST")
            //let value = snapshot.value as? NSDictionary
            //if let snapData = snapshot.value as? [String:Any] {
            //if let snapData = snapshot.value as? [Int:String] {
            //    print("QuizNames: \(snapData)")
            //}
        //})
        
        /*ref.child("quizzes").observeSingleEvent(of: .value, with: { (snapshot) in
            let snapData = snapshot.value as? [String:Any]
            /*// Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            let user = User(username: username)
            */
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }*/
        
        /*let exists = checkIfExistsInDatabase(path: "QuizNames")
        if (exists) {
            print("THIS IS A TEST")
            ref.child("quiz_names").observeSingleEvent(of: .value, with: { (snapshot) in
                if let snapData = snapshot.value as? [String:Any] {
                    print("QuizNames: \(snapData)")
                }
            })
        }
        else {
            print("Error: \(self.ref.child("quiz_names")) does NOT exist as a path.")
        }*/

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
    
    /*override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addHorizontalGradientLayer(leftColor: primaryColor, rightColor: secondaryColor)
        
        
        // set the Firebase reference
        ref = Database.database().reference()
        
        ref?.child("courses").observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapData = snapshot.value as? [String:Any] {
                // This will get entire dictionary from Firebase
                if let categoryArray = snapData["categories"] as? [[String:Any]]{
                    for (num, categoryObj) in categoryArray.enumerated() {
                        let name = categoryObj["name"] as? String
                        //print("Category \(num): \(name)")
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
                        
                        /*print("Category nubmer: \(categoryObj.element.count)")
                         let name = categoryObj.element["name"] as? String
                         let newCategory = Category(name: name!, id: categoryObj.offset)
                         
                         if let categoryQuestions = categoryObj.element["questions"] as? [[String:Any]] {
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
                         self.tableView.reloadData()*/
                        
                        
                    }
                }
            }
        })
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }*/
    
    /*internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Basic"
        case 1:
            return "Normal"
        case 2:
            return "Advanced"
        default:
            return "Section"
        }
    }*/
    
    /*func checkIfExistsInDatabase(path: String) -> Bool {
        var exists = false
        ref = Database.database().reference()
        // This will check whether or not the root/section path exists in the database
        ref.child(path).observeSingleEvent(of: .value, with: { (snapshot) in
            exists = snapshot.exists()
        })
        return exists
    }*/
    
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

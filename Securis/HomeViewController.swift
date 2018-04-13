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

struct Category {
    let name: String
    let id: Int
}

class HomeViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref:DatabaseReference?
    var categories = [Category]()
    
    var quizID:Int = 42
    var quizTitle:String? = "TEST"
    
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
                        self.categories.append(Category(name: name!, id: categoryObj.offset))
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toQuizView") {
            let quizViewController = segue.destination as! QuizViewController
            // Pass on the quizID and quizTitle
            quizViewController.quizID = quizID
            quizViewController.quizTitle = quizTitle
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



/*if segue.destination is QuizViewController
 {
 let viewController = segue.destination as? QuizViewController
 let quizID = sender as! Int
 viewController?.quizID = quizID
 }*/

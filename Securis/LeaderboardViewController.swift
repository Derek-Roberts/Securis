//
//  LeaderboardViewController.swift
//  Securis
//
//  Created by Derek Roberts on 4/14/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    struct User {
        var username: String?
        var score = 0.0
    }
    
    var ref:DatabaseReference!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addHorizontalGradientLayer(leftColor: primaryColor, rightColor: secondaryColor)
        
        nameLabel.text = Auth.auth().currentUser?.displayName
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(imageTap)
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.clipsToBounds = true
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(self.logout))
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("user_results/\(uid)")
        databaseRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let dict = snapshot.value as! [String:Double]
            for item in dict {
                print("HERE Is the item: '\(item.key) : \(item.value)")
                if item.key == "user_average" {
                    print("Found average: \(item.value)")
                    self.userAvg = item.value * 100
                    self.userTotalAverage.text = String(format: "%.0f", self.userAvg) + "%"
                } else {
                    let newResult = UserResults(name: item.key, score: item.value)
                    self.userResults.append(newResult)
                    self.tableView.reloadData()
                }
            }
            //databaseRef.updateChildValues(average)
        })
        //print("Adding result")
        //let result = [quizResults.quizName: quizResults.userAvgCorrect] as [String:Double]
        //databaseRef.updateChildValues(result)
        
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")! as! LeaderboardTableViewCell
        let name = userResults[indexPath.row].name
        cell.quizName.text = name
        let score = userResults[indexPath.row].score
        cell.quizScore.text = String(format: "%.0f", score*100) + "%"
        
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

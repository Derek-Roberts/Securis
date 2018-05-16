//
//  LeaderboardViewController.swift
//  Securis
//
//  Created by Derek Roberts on 4/14/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    struct User {
        var username: String?
        var score = 0.0
        var imageUrl: String?
    }
    
    var ref:DatabaseReference!
    
    var users = [UserProfile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addHorizontalGradientLayer(leftColor: primaryColor, rightColor: secondaryColor)
        
        observeUsers()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func observeUsers() {
        let userResultsRef = Database.database().reference().child("users/profile/")
        
        userResultsRef.observe(.value, with: { snapshot in
            
            var tempUsers = [UserProfile]()
            
            for child in snapshot.children {
                let uid = ""
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let username = dict["username"] as? String,
                    let photoURL = dict["photoURL"] as? String,
                    let url = URL(string:photoURL),
                    let average = dict["average"] as? Double {
                    
                    let userProfile = UserProfile(uid: uid, username: username, photoURL: url, average: average)
                    tempUsers.append(userProfile)
                }
            }
            
            self.users = tempUsers
            self.users = self.users.sorted(by: { $0.average > $1.average })
            self.tableView.reloadData()
            
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")! as! LeaderboardTableViewCell
        let name = users[indexPath.row].username
        cell.username.text = name
        let score = users[indexPath.row].average
        cell.score.text = String(format: "%.0f", score*100) + "%"
        ImageService.getImage(withURL: users[indexPath.row].photoURL) { image in
            //cell.imageView?.image = image
            cell.profileImage.image = image
        }
        
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

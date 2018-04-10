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

class HomeViewController:UIViewController {
    
    @IBOutlet weak var categoryTable: UITableView!
    
    var ref:DatabaseReference?
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addHorizontalGradientLayer(leftColor: primaryColor, rightColor: secondaryColor)
        
        // set the Firebase reference
        ref = Database.database().reference()

        ref?.child("courses").observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapData = snapshot.value as? [String:Any] {
                // This will get entire dictionary from your JSON.
                if let categoryArray = snapData["categories"] as? [[String:Any]]{
                    for categoryObj in categoryArray.enumerated() {
                        let name = categoryObj.element["name"] as? String
                        self.categories.append(Category(name: name!, id: categoryObj.offset))
                    }
                }
            }
        })
        
        // retrieve the categories
        //ref?.child("Categories/Basic: 1").observeSingleEvent(of: .value, with: { (snapshot) in
        /*ref?.child("Categories").observeSingleEvent(of: .value, with: { (snapshot) in
            
            // Code to execute when a child is added under Categories
            // Take value from snapshot and add it to the categoryData array
            //let category = snapshot.value as? String
            //self.categoryData.append(category!)
            
            let value = snapshot.value as? NSDictionary
            //let question = value?["01"] as? Int ?? 0
            
            //let category = value?["category"] as? String ?? ""
            
        })*/
        
    }
    
    @IBAction func logout(_ sender: Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
}

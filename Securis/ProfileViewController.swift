//
//  ProfileViewController.swift
//  Securis
//
//  Created by Derek Roberts on 4/13/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITabBarDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tapToChangeProfileImageButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userTotalAverage: UILabel!
    
    struct UserResults {
        var name: String?
        var score = 0.0
    }
    
    var ref:DatabaseReference!
    var userAvg: Double!

    var userResults = [UserResults]()
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addHorizontalGradientLayer(leftColor: primaryColor, rightColor: secondaryColor)
        
        guard let userProfile = UserService.currentUserProfile else { return }
        nameLabel.text = userProfile.username
        ImageService.getImage(withURL: userProfile.photoURL) { image in
            self.profileImage.image = image
        }
        
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
        
        self.userTotalAverage.text = String(format: "%.0f", userProfile.average*100) + "%"
        
        let databaseRef = Database.database().reference().child("user_results/\(userProfile.uid)")
        databaseRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let dict = snapshot.value as! [String:Double]
            
            // Sort the dictionary
            let dictTupleArray = dict.sorted{ $0.value > $1.value }
            for (quiz,score) in dictTupleArray {
                let newResult = UserResults(name: quiz, score: score)
                self.userResults.append(newResult)
                self.tableView.reloadData()
            }
        })

        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizCell")! as! ProfileQuizTableViewCell
        let name = userResults[indexPath.row].name
        cell.quizName.text = name
        let score = userResults[indexPath.row].score
        cell.quizScore.text = String(format: "%.0f", score*100) + "%"
        
        
        return cell
    }
    
    // Used for the tapToChangeProfileImageButton
    @IBAction func openPhotoLibraryButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func openImagePicker(_ sender:Any) {
        // Open the Image Picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/profile/\(uid)")
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.75) else { return }
        
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                if let url = metaData?.downloadURL() {
                    completion(url)
                } else {
                    completion(nil)
                }
                // success!
            } else {
                // failed
                completion(nil)
            }
        }
    }
    
    func updateUserImage(profileImageURL:URL, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        let userObject = ["photoURL": profileImageURL.absoluteString] as [String:Any]
        
        databaseRef.updateChildValues(userObject) { error, ref in
            completion(error == nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func logout() {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }

}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.profileImage.image = pickedImage
            self.uploadProfileImage(pickedImage) { url in
                if url != nil {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.photoURL = url
                    changeRequest?.commitChanges { error in
                        if error == nil {
                            self.updateUserImage(profileImageURL: url!) { success in
                                if success {
                                    print("User profile image has been changed!")
                                }
                            }
                        } else {
                            print("Error: \(error!.localizedDescription)")
                        }
                    }
                } else {
                    // Error unable to upload profile image
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}

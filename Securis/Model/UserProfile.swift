//
//  UserProfile.swift
//  Securis
//
//  Created by Derek Roberts on 3/20/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import Foundation

class UserProfile {
    var uid:String
    var username:String
    var photoURL:URL
    var average:Double
    
    init(uid:String, username:String, photoURL:URL, average:Double) {
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
        self.average = average
    }
    
}

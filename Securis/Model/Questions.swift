//
//  Questions.swift
//  Securis
//
//  Created by Derek Roberts on 4/9/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import Foundation

class Question {
    let question: String
    let answer: Int
    let o1: String
    let o2: String
    let o3: String
    let o4: String
    
    init(question: String, answer: Int, o1: String, o2: String, o3: String, o4: String) {
        self.question = question
        self.answer = answer
        self.o1 = o1
        self.o2 = o2
        self.o3 = o3
        self.o4 = o4
    }
    
}

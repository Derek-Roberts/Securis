//
//  UserAnswer.swift
//  Securis
//
//  Created by Derek Roberts on 4/28/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import Foundation

import Foundation

class UserAnswer {
    let questionNumber: Int
    let question: String
    let answer: String
    let chosen: String
    let correct: Bool
    
    init(questionNumber: Int, question: String, answer: String, chosen: String) {
        self.questionNumber = questionNumber
        self.question = question
        self.answer = answer
        self.chosen = chosen
        if (answer == chosen) {
            self.correct = true
        } else {
            self.correct = false
        }
    }
    
}

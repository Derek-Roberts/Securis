//
//  QuizResults.swift
//  Securis
//
//  Created by Derek Roberts on 4/28/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import Foundation
import FirebaseDatabase

class QuizResults {
    var quizName: String
    var answers = [UserAnswer]()
    var userAvgCorrect: Double
    
    init() {
        self.quizName = "nil"
        self.userAvgCorrect = 0.0
    }
    
    func setQuizName(name: String) {
        self.quizName = name
    }
    
    func addAnswer(userAnswer: UserAnswer) {
        self.answers.append(userAnswer)
    }
    
    func setUserAvgCorrect(userAvgCorrect: Double) {
        self.userAvgCorrect = userAvgCorrect
    }
    
}

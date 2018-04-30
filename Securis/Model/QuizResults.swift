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
    let quizName: String
    var answers = [UserAnswer]()
    var userAvgCorrect: Double
    var globalAvgCorrect: Double
    
    init(quizName: String) {
        self.quizName = quizName
        self.userAvgCorrect = 0.0
        self.globalAvgCorrect = 0
    }
    
    func addAnswer(userAnswer: UserAnswer) {
        self.answers.append(userAnswer)
    }
    
    func setUserAvgCorrect(userAvgCorrect: Double) {
        self.userAvgCorrect = userAvgCorrect
    }
    
    /*func updateGlobalAvgCorrect() {
        var ref:DatabaseReference?
        
    }*/
    
}

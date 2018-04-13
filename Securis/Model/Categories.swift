//
//  Categories.swift
//  Securis
//
//  Created by Derek Roberts on 3/30/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import Foundation

class Category {
    let name: String
    let id: Int
    var questions = [Question]()
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    func addQuestion(question: Question) {
        self.questions.append(question)
    }
    
}

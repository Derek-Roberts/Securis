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
    
    func shuffleQuestions() {
        self.questions.shuffle()
    }
    
}

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

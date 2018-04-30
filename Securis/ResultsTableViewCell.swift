//
//  ResultsTableViewCell.swift
//  Securis
//
//  Created by Derek Roberts on 4/29/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    @IBOutlet weak var selectedAnswer: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

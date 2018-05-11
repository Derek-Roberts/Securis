//
//  ProfileQuizCell.swift
//  Securis
//
//  Created by Derek Roberts on 5/11/18.
//  Copyright © 2018 Derek Roberts. All rights reserved.
//

import Foundation
import UIKit

class ProfileQuizTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quizName: UILabel!
    @IBOutlet weak var quizScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

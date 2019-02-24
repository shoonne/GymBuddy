//
//  WorkoutFactsDetailTextCellTableViewCell.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2019-02-10.
//  Copyright © 2019 ShaonDesign. All rights reserved.
//

import UIKit

class WorkoutFactsDetailTextCell: UITableViewCell {
    
    @IBOutlet var workoutFactsLabel: UILabel! {
        didSet {
            workoutFactsLabel.numberOfLines = 0
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

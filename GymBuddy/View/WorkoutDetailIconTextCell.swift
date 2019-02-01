//
//  WorkoutDetailIconTextCellTableViewCell.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2018-12-30.
//  Copyright © 2018 ShaonDesign. All rights reserved.
//

import UIKit

class WorkoutDetailIconTextCell: UITableViewCell {
    
    @IBOutlet var iconImageView : UIImageView!
    @IBOutlet var workoutDescriptionLabel: UILabel! {
        didSet {
            workoutDescriptionLabel.numberOfLines = 0
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

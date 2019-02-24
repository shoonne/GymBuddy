//
//  WorkoutFactsTableViewCell.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2019-02-10.
//  Copyright © 2019 ShaonDesign. All rights reserved.
//

import UIKit

class WorkoutFactsTableViewCell: UITableViewCell {
    
    @IBOutlet var workoutNameLabel: UILabel!
    @IBOutlet var workoutImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

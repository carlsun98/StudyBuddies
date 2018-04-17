//
//  DurationSelectionTableViewCell.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/16/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

class DurationSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var stepperControl: UIStepper!
    @IBOutlet weak var durationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func stepperPressed(_ sender: UIStepper) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

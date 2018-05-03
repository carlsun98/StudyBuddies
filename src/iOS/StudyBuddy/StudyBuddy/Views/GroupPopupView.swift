//
//  GroupPopupView.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 5/2/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

class GroupPopupView: UIView {

    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var groupSizeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var locationLabel: UITextView!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "GroupPopupView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

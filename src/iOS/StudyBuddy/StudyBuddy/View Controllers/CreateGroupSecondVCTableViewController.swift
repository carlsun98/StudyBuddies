//
//  CreateGroupSecondVCTableViewController.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/16/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

class CreateGroupSecondVCTableViewController: UITableViewController {

    @IBOutlet weak var generalReviewCategoryCell: CategorySelectionTableViewCell!
    @IBOutlet weak var examPrepCategoryCell: CategorySelectionTableViewCell!
    @IBOutlet weak var homeworkCategoryCell: CategorySelectionTableViewCell!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var stepperControl: UIStepper!
    @IBOutlet weak var durationLabel: UILabel!
    
    public var selectedCategory = -1
    public var duration = 30
    public var groupDescription = ""
    
    public func getGroupDescription() -> String {
        return descriptionTextView.text
    }
    
    public func getDuration() -> Int {
        return Int(stepperControl.value)
    }
    
    public func getSelectedCategoryIndex() -> Int {
        return selectedCategory
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myParent = self.parent as! CreateGroupSecondViewController
        myParent.childViewController = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        descriptionTextView.inputAccessoryView = toolBar
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }

    @IBAction func stepperPressed(_ sender: Any) {
        let duration = Int(stepperControl.value)
        if duration >= 60 {
            durationLabel.text = "\(duration / 60)h \(duration % 60)m"
        } else {
            durationLabel.text = "\(duration)m"
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == selectedCategory && indexPath.section == 1) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            selectedCategory = indexPath.row
            homeworkCategoryCell.accessoryType = .none
            examPrepCategoryCell.accessoryType = .none
            generalReviewCategoryCell.accessoryType = .none
            if indexPath.row == 0 {
                homeworkCategoryCell.accessoryType = .checkmark
            } else if indexPath.row == 1 {
                examPrepCategoryCell.accessoryType = .checkmark
            } else {
                generalReviewCategoryCell.accessoryType = .checkmark
            }
        }
        tableView .deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
//  CreateGroupSecondViewController.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

class CreateGroupSecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let categories = ["Homework", "Exam Prep", "General Studying"]
    var duration: Int = 30
    var selectedCategory = -1
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return categories.count
        }
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Select Duration"
        case 1:
            return "Select Category"
        case 2:
            return "Enter Description"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "durationCell") as! DurationSelectionTableViewCell
            if (duration >= 60) {
                cell.durationLabel.text = "\(duration / 60)h \(duration % 60)m"
            } else {
                cell.durationLabel.text = "\(duration) mins"
            }
            cell.stepperControl.value = Double(duration)
            cell.stepperControl.stepValue = 5.0
            cell.stepperControl.addTarget(self, action: #selector(stepperValueChanged(sender:)), for: .valueChanged)
            return cell
            
        } else if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as! CategorySelectionTableViewCell
            cell.categoryLabel.text = categories[indexPath.row]
            if selectedCategory == indexPath.row {
                cell.accessoryType = .checkmark
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "studyDescriptionDetailCell") as! StudyDescriptionTableViewCell
            return cell
        }
    }
    
    @objc func stepperValueChanged(sender: UIStepper) {
        duration = Int(sender.value)
        tableView.reloadData()
    }

    @IBAction func nextPressed(_ sender: Any) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

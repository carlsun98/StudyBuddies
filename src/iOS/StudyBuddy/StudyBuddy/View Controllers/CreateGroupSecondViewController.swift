//
//  CreateGroupSecondViewController.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

class CreateGroupSecondViewController: UIViewController {

    let categories = ["Homework", "Exam Prep", "General Studying"]
    public var childViewController: CreateGroupSecondVCTableViewController? = nil
    public var group: Group? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Study Group"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        let description = childViewController?.getGroupDescription()
        let categoryIndex = childViewController?.getSelectedCategoryIndex()
        if (categoryIndex == -1) {
            let alertController = UIAlertController(title: "Please select a category", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        group?.description = description!
        group?.category = categories[categoryIndex!]
        performSegue(withIdentifier: "NextGroupScreenSegue", sender: self)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EmbedChildViewControllerSegue" {
            if let destination = segue.destination as? CreateGroupSecondVCTableViewController {
                self.childViewController = destination
            }
        }
        if segue.identifier == "NextGroupScreenSegue" {
            if let destination = segue.destination as? CreateGroupThirdViewController {
                destination.group = group
                destination.duration = childViewController?.getDuration()
            }
        }
    }
    

}

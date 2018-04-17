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
    var duration: Int = 30
    var selectedCategory = -1
    
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
        performSegue(withIdentifier: "NextGroupScreenSegue", sender: self)
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

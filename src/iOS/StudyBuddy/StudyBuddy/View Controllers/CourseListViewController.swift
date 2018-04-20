//
//  ClassListViewController.swift
//  StudyBuddy
//
//  Created by Malika Oak on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

class CourseListViewController: UITableViewController {
    
    var editButton: UIBarButtonItem? = nil
    var doneButton: UIBarButtonItem? = nil
    var addCell: UITableViewCell? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Courses"
        NotificationCenter.default.addObserver(self, selector: #selector(dataLoaded), name: .dataLoaded, object: nil)
        // Do any additional setup after loading the view.
        editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonClick))
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonClick))
        self.navigationItem.rightBarButtonItem = editButton
        addCell = UITableViewCell(style: .default, reuseIdentifier: nil)
        addCell?.textLabel?.text = "Add Course"
    }
    
    @objc func doneButtonClick() {
        tableView.setEditing(false, animated: true)
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func editButtonClick() {
        tableView.setEditing(true, animated: true)
        self.navigationItem.rightBarButtonItem = doneButton
        let addPath = IndexPath(row: 0, section: 0)
        //tableView.insertRows(at: [addPath], with: .top)
    }
    
    @objc func dataLoaded() {
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.sharedInstance.courses.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            return addCell!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell") as! CourseTableViewCell
        let course = Data.sharedInstance.courses[indexPath.row - 1]
        let abbr = course.abbrv
        let num = course.number
        cell.mainLabel.text = abbr + " " + num
        cell.sideLabel.text = "\(course.groups.count)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.row > 0) {
            return true
        }
        return false
    }
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "showSearchView", sender: self)
        }
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

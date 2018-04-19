//
//  ClassSearchTableViewController.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/16/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

class CourseSearchTableViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {
    var searchResults: Array<Course> = []
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Course"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        tableView.setEditing(true, animated: false)
        tableView.allowsSelectionDuringEditing = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func donePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell") as! CourseSelectionTableViewCell
        let course = searchResults[indexPath.row]
        let abbr = course.abbrv
        let num = course.number
        cell.courseTitle.text = abbr + " " + num
        if (!Data.sharedInstance.courses.contains(where: {$0.id == course.id})) {
            cell.courseTitle.text = abbr + " " + num + " (Added)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.insert
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        addCourse(searchResults[indexPath.row])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addCourse(searchResults[indexPath.row])
    }
    
    func addCourse(_ course: Course) {
        let token = Data.sharedInstance.sessionToken
        let urlAPI = Network.getUrlForAPI(kAddClassApi)
        let classID = "\(course.id)"
        let parameters = ["session_token": token, "class_id": classID]
        Network.sendRequest(toURL: urlAPI!, parameters: parameters, success: { (_:Any, response:Array<Dictionary>) in
            if (response.count == 0) {
                let alertController = UIAlertController(title: "Uh oh :(", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            let success = response[0]["success"] as! Int
            let message = response[0]["message"] as! String
            if (success == 1) {
                Data.sharedInstance.courses.append(course)
                self.dismiss(animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Uh oh :(", message: message, preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.presentingViewController?.present(alertController, animated: true, completion: nil)
                return
            }
        }) { (_:Any, error:Error) in
            let alertController = UIAlertController(title: "Uh oh :(", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        let token = Data.sharedInstance.sessionToken
        let urlAPI = Network.getUrlForAPI(kClassesListApi)
        let searchText = searchController.searchBar.text
        if ((searchText?.count)! < 1) {
            searchResults = []
            tableView.reloadData()
            return
        }
        let parameters = ["session_token": token, "search_string": searchText]
        Network.sendRequest(toURL: urlAPI!, parameters: parameters, success: { (_:Any, response:Array<Dictionary>) in
            if (response.count == 0) {
                let alertController = UIAlertController(title: "Uh oh :(", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            let success = response[0]["success"] as! Int
            let message = response[0]["message"] as! String
            if (success == 1) {
                let courseData = response[1]["classes"] as! Array<Dictionary<String, Any>>
                var courses: Array<Course> = []
                for course in courseData {
                    let newCourse = Course()
                    newCourse.abbrv = course["course_abbreviation"] as! String
                    newCourse.number = course["course_number"] as! String
                    newCourse.title = course["course_title"] as! String
                    newCourse.id = course["id"] as! Int
                    courses.append(newCourse)
                }
                self.searchResults = courses
                self.tableView.reloadData()
            } else {
                let alertController = UIAlertController(title: "Uh oh :(", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }) { (_:Any, error:Error) in
            let alertController = UIAlertController(title: "Uh oh :(", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
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

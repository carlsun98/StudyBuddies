//
//  GroupPageViewController.swift
//  StudyBuddy
//
//  Created by Malika Oak on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit
import QuartzCore

class GroupPageViewController: UITableViewController {
    @IBOutlet weak var getCourseLabel: UILabel!
    @IBOutlet weak var getLocationLabel: UILabel!
    @IBOutlet weak var getSizeLabel: UILabel!
    @IBOutlet weak var getEndTimeLabel: UILabel!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 1 && indexPath.section == 1) {
            leaveGroup()
        }
    }
    
    func updateGroup() {
        let currGroup = Data.sharedInstance.currentGroup
        getCourseLabel.text = currGroup.course.abbrv + " " + currGroup.course.number
        getLocationLabel.text = currGroup.locationDescription
        getSizeLabel.text = "\(currGroup.size)"
        getEndTimeLabel.text = "\(currGroup.endtime)"
    }
    func leaveGroup() {
        let token = Data.sharedInstance.sessionToken
        let parameters = ["session_token": token]
        let urlAPI = Network.getUrlForAPI(kLeaveGroupApi)
        
        NotificationCenter.default.post(name: .currentGroupChanged, object: nil)

        Network.sendRequest(toURL: urlAPI!, parameters: parameters, success: { (_:Any, response:Array<Dictionary>) in
            if (response.count == 0) {
                let alertController = UIAlertController(title: "Network Error", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            let success = response[0]["success"] as! Int
            let message = response[0]["message"] as! String
            if (success == 1) {
                self.dismiss(animated: true, completion: nil)
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
    
    @objc func groupChanged() {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Group"
        NotificationCenter.default.addObserver(self, selector: #selector(groupChanged), name: .currentGroupChanged, object: nil)
        // Do any additional setup after loading the view.
        var coverUp = UIView(frame: self.tableView.frame)
        let y = self.tableView.center.y - 10
        let frame = CGRect(x: 0, y: y, width: self.tableView.frame.width, height: 20)
        let label = UITextView(frame: frame)
        label.text = "You are not in a group. Please join a group to see its details."
        coverUp.backgroundColor = UIColor(red: 30/255.0, green: 30/255.0, blue: 70/255.0, alpha: 1.0)
        coverUp.addSubview(label)
        self.tableView.addSubview(coverUp)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

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
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UITextView!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0 && indexPath.section == 1) {
            leaveGroup()
        }
    }
    
    func updateGroup() {
        if Data.sharedInstance.currentGroup == nil {
            courseLabel.text = "NONE"
            locationLabel.text = "NONE"
            sizeLabel.text = "NONE"
            endTimeLabel.text = "NONE"
            return
        }
        
        let currGroup = Data.sharedInstance.currentGroup!
        courseLabel.text = currGroup.course.name
        locationLabel.text = currGroup.locationDescription
        sizeLabel.text = "\(currGroup.size)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        endTimeLabel.text = "\(dateFormatter.string(from: currGroup.endtime))"
        descriptionLabel.text = currGroup.description
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
                Data.sharedInstance.currentGroup = nil
                NotificationCenter.default.post(name: .currentGroupChanged, object: nil)
                Data.sharedInstance.fetchClasses(succeed: { (response: Any?) in
                    
                }, error: { (message: String) in
                    
                }, failure: { (error: Error) in
                    
                })
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Group"
        // Do any additional setup after loading the view.
        updateGroup()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

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
    @IBOutlet weak var getLocationLabel: UITextView!
    @IBOutlet weak var getSizeLabel: UILabel!
    @IBOutlet weak var getEndTimeLabel: UILabel!
    
    var coverUpView: UIView? = nil
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 1 && indexPath.section == 1) {
            leaveGroup()
        }
    }
    
    func updateGroup() {
        if Data.sharedInstance.currentGroup == nil {
            return
        }
        
        let currGroup = Data.sharedInstance.currentGroup!
        getCourseLabel.text = currGroup.course.name
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
                Data.sharedInstance.currentGroup = nil
                self.groupChanged()
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
        if (Data.sharedInstance.currentGroup == nil) {
            if (!tableView.subviews.contains(coverUpView!)) {
                tableView.addSubview(coverUpView!)
                
            }
        } else {
            coverUpView?.removeFromSuperview()
            updateGroup()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Group"
        NotificationCenter.default.addObserver(self, selector: #selector(groupChanged), name: .currentGroupChanged, object: nil)
        // Do any additional setup after loading the view.
        updateGroup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = CGFloat(30.0)
        coverUpView?.removeFromSuperview()
        coverUpView = UIView(frame: self.tableView.frame)
        let y = self.tableView.center.y - height / 2
        let frame = CGRect(x: 0, y: y, width: self.tableView.frame.width, height: height)
        let textView = UITextView(frame: frame)
        textView.text = "Join or create a group to see it here."
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        coverUpView!.backgroundColor = UIColor(red: 30/255.0, green: 30/255.0, blue: 70/255.0, alpha: 1.0)
        coverUpView!.addSubview(textView)
        
        if (Data.sharedInstance.currentGroup == nil) {
            tableView.addSubview(coverUpView!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

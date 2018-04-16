//
//  ClassListViewController.swift
//  StudyBuddy
//
//  Created by Malika Oak on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

class ClassListViewController: UITableViewController {
    
    var courses: Array<Course> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let apiUrl = Network.getUrlForAPI(kUserClasses)
        Network.sendRequest(toURL: apiUrl!, parameters: ["session_token": Data.sharedInstance.sessionToken], success: { (_:Any, response:Array<Dictionary>) in
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
                print(response[1]) 
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Data Source
    
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }*/
    
    // MARK: - Delegate

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  InitialViewController.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/16/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit
import MBProgressHUD
class InitialViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storedToken = UserDefaults.standard.string(forKey: "session_token")
        if (storedToken == nil || storedToken == "") {
            self.performSegue(withIdentifier: "kShowLoginSegue", sender: nil)
        } else {
            Data.sharedInstance.sessionToken = storedToken!
        }
        // Do any additional setup after loading the view.
        let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = "Loading"
        
        Data.sharedInstance.fetchClasses(succeed: { (response: Any?) in
            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        }, error: { (message: String) in
            if (message == "msg_invalid_token") {
                self.performSegue(withIdentifier: "kShowLoginSegue", sender: nil)
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            }
        }) { (error: Error) in
            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            let alertController = UIAlertController(title: "Uh oh :(", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        Data.sharedInstance.getCurrentGroup(succeed: { (response: Any?) in
            
        }, error: { (message: String) in
            
        }) { (error: Error) in
            
        }
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

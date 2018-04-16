//
//  SettingsViewController.swift
//  StudyBuddy
//
//  Created by Malika Oak on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet weak var notificationSwitch: UISwitch!
    
    @IBAction func logoutButton(_ sender: Any) {
            performSegue(withIdentifier: "prepareForUnwind", sender: self)
    }
    
    @IBAction func notificationChange(_ sender: Any) {
        var push_notifications_enabled = 0
        if notificationSwitch.isOn {
            push_notifications_enabled = 1
        }
        let token = UserDefaults.standard.string(forKey: "session_token");
        let parameters = ["push_notifications_enabled": push_notifications_enabled, "Apple_APN_Key": token] as [String : Any]
        let urlAPI = Network.getUrlForAPI(kUpdateUserApi)
        
        Network.sendRequest(toURL: urlAPI!, parameters: parameters, success: { (_:Any, response:Array<Dictionary>) in
            if (response.count == 0) {
                let alertController = UIAlertController(title: "Network Error", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            print(response)
            self.dismiss(animated: true, completion: nil)
        }) { (_:Any, error:Error) in
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

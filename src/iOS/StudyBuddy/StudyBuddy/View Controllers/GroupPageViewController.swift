//
//  GroupPageViewController.swift
//  StudyBuddy
//
//  Created by Malika Oak on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

class GroupPageViewController: UIViewController {

    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var noMemLabel: UILabel!
    
    @IBAction func leaveGroup(_ sender: Any) {
        let token = UserDefaults.standard.string(forKey: "session_token");
        let parameters = ["session_token": token]
        let urlAPI = Network.getUrlForAPI(kLeaveGroupApi)
        
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Group"
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

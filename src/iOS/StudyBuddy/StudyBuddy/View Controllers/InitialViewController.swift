//
//  InitialViewController.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/16/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

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

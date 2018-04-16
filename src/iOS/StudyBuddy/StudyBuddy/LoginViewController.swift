//
//  LoginViewController.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    

    @IBAction func loginPressed(_ sender: Any) {
        let username = usernameTF.text
        let password = passwordTF.text
        let urlAPI = Network.getUrlForAPI(kLoginApi)
        let parameters = ["email": username, "password": password]
        Network.sendRequest(toURL: urlAPI!, parameters: parameters, success: { (_:Any, response:Array<Dictionary>) in
            if (response.count == 0) {
                let alertController = UIAlertController(title: "Network Error", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            let success = response[0]["success"] as! Int
            if (success == 1) {
                UserDefaults.standard.set(response[1]["token"], forKey: "session_token");
                self.dismiss(animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Invalid login", message: "Check your credentials", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }) { (_:Any, error:Error) in
            
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

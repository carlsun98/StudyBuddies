//
//  LoginViewController.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit
import MBProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        passwordTF.inputAccessoryView = toolBar
        usernameTF.inputAccessoryView = toolBar
        
        navigationItem.title = "Welcome to StudyBuddy"
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue) { }

    
    
    @IBAction func loginPressed(_ sender: Any) {
        let username = usernameTF.text
        let password = passwordTF.text
        let urlAPI = Network.getUrlForAPI(kLoginApi)
        let parameters = ["email": username, "password": password]
       
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
                UserDefaults.standard.set(response[1]["token"], forKey: "session_token");
                self.getData()
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
    
    func getData() {
        Data.sharedInstance.fetchClasses(succeed: { (response: Any?) in
            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
        }, error: { (message: String) in
            if (message == "msg_invalid_token") {
                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            }
        }) { (error: Error) in
            MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
            let alertController = UIAlertController(title: "Uh oh :(", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

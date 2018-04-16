//
//  CreateUserViewController.swift
//  StudyBuddy
//
//  Created by Malika Oak on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var yearTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confPasswordTF: UITextField!
    
    @IBAction func sendEmail(_ sender: Any) {
        let email = usernameTF.text
        let password = passwordTF.text
        let name = nameTF.text
        let class_year = yearTF.text
        let urlAPI = Network.getUrlForAPI(kCreateUserApi)
        let parameters = ["email": email, "password": password, "name": name, "class_year": class_year]
        Network.sendRequest(toURL: urlAPI!, parameters: parameters, success: { (_:Any, response:Array<Dictionary>) in
            if (response.count == 0) {
                let alertController = UIAlertController(title: "Network Error", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            if (self.passwordTF != self.confPasswordTF) {
                let alertController = UIAlertController(title: "Invalid Input", message: "Your passwords do not match!", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            let success = response[0]["success"] as! Int
            if (success == 1) {
                self.performSegue(withIdentifier: "sendEmailSegue", sender: self)
            } else {
                let alertController = UIAlertController(title: "Invalid Input", message: "Check your credentials", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
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

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
                let alertController = UIAlertController(title: "Uh oh :(", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            if (self.passwordTF.text != self.confPasswordTF.text) {
                let alertController = UIAlertController(title: "Invalid Input", message: "Your passwords do not match!", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            let success = response[0]["success"] as! Int
            if (success == 1) {
                let alertController = UIAlertController(title: "Creating Your Account", message: "A confirmation email has been sent to you. Please follow the link in the email!", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Cancel", style: .default)
                if let gmailUrl = URL(string: "googlegmail://") {
                    if UIApplication.shared.canOpenURL(gmailUrl) {
                        let openEmailAction = UIAlertAction(title: "Open Gmail", style: .default, handler: { (action) in
                            UIApplication.shared.open(gmailUrl, options: [:], completionHandler: nil)
                            }
                        )
                        alertController.addAction(openEmailAction)
                    }
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }
            else {
                let alertController = UIAlertController(title: "Something went wrong", message: "Maybe you already have an account?", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }) { (_:Any, error:Error) in
            let alertController = UIAlertController(title: "Oh oh :(", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Welcome to StudyBuddy"
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

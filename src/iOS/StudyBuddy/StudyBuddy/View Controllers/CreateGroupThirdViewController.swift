//
//  CreateGroupThirdViewController.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit

class CreateGroupThirdViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    public var group: Group? = nil
    public var duration: Int? = nil // sent from previous view controller
    public var childViewController: CreateGroupThirdVCTableViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Study Group"
        // Do any additional setup after loading the view.
    }

    @IBAction func donePressed(_ sender: Any) {
        let marker = childViewController?.getCoords()
        if (marker == nil) {
            let alertController = UIAlertController(title: "Please select a location", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        group?.location_lat = (marker?.position.latitude)!
        group?.location_lon = (marker?.position.longitude)!
        group?.starttime = Date()
        group?.endtime = Date(timeInterval: Double(duration!) * 60.0, since: (group?.starttime)!)
        group?.size = 1
        group?.locationDescription = (childViewController?.getLocationDescription())!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let endtime = dateFormatter.string(from: group!.endtime)

        
        
        let parameters = ["session_token": Data.sharedInstance.sessionToken, "class_id": "\(group!.course.id)", "end_time": endtime, "category": group!.category, "description": group!.description, "location_lat": "\(group!.location_lat)", "location_lon": "\(group!.location_lon)", "location_description": group!.locationDescription]
        let apiUrl = Network2.sharedInstance.getURLForAPI(kCreateGroupApi)
        Network2.sharedInstance.sendRequestToURL(url: apiUrl, parameters: parameters, success: { (response: Any?) in
            let data = response as! Array<Dictionary<String, Any>>
            if (data.count == 0) {
                let alertController = UIAlertController(title: "Uh oh :(", message: "Something went wrong", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            let success = data[0]["success"] as! Int
            let message = data[0]["message"] as! String
            if (success == 1) {
                Data.sharedInstance.fetchClasses(succeed: { (response: Any?) in
                    //
                }, error: { (message: String) in
                    //
                }) { (error: Error) in
                    //
                }
                Data.sharedInstance.getCurrentGroup(succeed: { (response: Any?) in
                    //
                }, error: { (message: String) in
                    //
                }) { (error: Error) in
                    //
                }
                self.dismiss(animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Uh oh :(", message: message, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }) { (error: Error) in
            
        }
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EmbedChildViewControllerSegue" {
            if let destination = segue.destination as? CreateGroupThirdVCTableViewController {
                self.childViewController = destination
            }
        }
    }

}







/* var latitudeText:String = "\(marker!.position.latitude)"
 var longitudeText:String = "\(marker!.position.longitude)"
 
 let url = URL(string: "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(latitudeText),\(longitudeText)&radius=100&key=AIzaSyBG4O6fDW2ujIozTp0fQNxfRP9juIMLmKc&?rankby=disance&?type=point_of_interest")
 
 var closest_building = ""
 
 URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
 guard let data = data, error == nil else { return }
 
 do {
 let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
 print (json)
 let posts = json["results"] as? [Int: [String]]
 let firstOne = posts![0]
 print ("----------------------NAMES---------------------")
 print(posts)
 } catch let error as NSError {
 print(error)
 }
 }).resume() */

/*  if let url = urlString {
 let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
 let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary
 print (jsonObj!!)
 }
 // let closest_building = jsonObj!![0]!["name"]
 
 
 /* if error != nil {
 print(error!)
 } else {
 if let usableData = data {
 // let json = try JSONSerialization.jsonObject(with: usableData) as? [String: Any]
 print(usableData) //JSONSerialization
 }
 }*/
 
 task.resume() } */

/* let refreshAlert = UIAlertController(title: "Closest Location", message: "Did you mean \(closest_building)", preferredStyle: UIAlertControllerStyle.alert)
 
 refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
 print("Location Changed")
 }))
 
 refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
 print("Locatioon Not Changed")
 }))
 
 present(refreshAlert, animated: true, completion: nil) */

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
        let locationDescription = childViewController?.getLocationDescription()
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
        
        /*let parameters = ["class_id": "\(group?.course.id)", "end_time": group?.endtime, "category": group?.category, "description": group?.description, "location_lat": "\(group?.location_lat)", "location_lon": "\(group?.location_lon)", "location_description": group?.locationDescription]*/
        dismiss(animated: true, completion: nil)
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

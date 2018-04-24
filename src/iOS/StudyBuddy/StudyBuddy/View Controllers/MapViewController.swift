//
//  MapViewController.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {

    var selectedGroup: Group? = nil
    var mapView: GMSMapView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Study Groups"
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        
        let camera = GMSCameraPosition.camera(withLatitude: 40.3440, longitude: -74.6514, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        NotificationCenter.default.addObserver(self, selector: #selector(displayMarkers), name: .dataLoaded, object: nil)
        
        view.insertSubview(mapView!, at: 0)
        // self.mapView?.delegate = self as! GMSMapViewDelegate
    }

    @objc func displayMarkers() {
        mapView!.clear()
        for aCourse in Data.sharedInstance.courses {
            for aGroup in aCourse.groups {
                let courseLat = aGroup.location_lat
                let courseLong = aGroup.location_lon
                let position = CLLocationCoordinate2D(latitude: courseLat, longitude: courseLong)
                let marker = GMSMarker(position: position)
                marker.title = aGroup.course.title
                marker.map = mapView
                marker.userData = aGroup
            }
        }
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        Data.sharedInstance.fetchClasses(succeed: { (response: Any?) in
            self.displayMarkers()
        }, error: { (message: String) in
            //
        }) { (error: Error) in
            //
        }
    }
    @IBAction func joinGroupButton(_ sender: Any) {
        let urlAPI = Network.getUrlForAPI(kJoinGroupApi)
        let token = Data.sharedInstance.sessionToken
        
        if (selectedGroup == nil) {
            let alertController = UIAlertController(title: "Please select a group to join", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.default)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let parameters = ["group_id": selectedGroup!.id, "session_token": token] as [String : Any]
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
            print(response)
            if (success == 1) {
                Data.sharedInstance.currentGroup = self.selectedGroup!
                NotificationCenter.default.post(name: .currentGroupChanged, object: nil)
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
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        selectedGroup = marker.userData as? Group
        // print ("MarkerTapped Locations: \(marker.position.latitude), \(marker.position.longitude)")
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

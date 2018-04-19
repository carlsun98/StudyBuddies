//
//  MapViewController.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
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
    }
    
    @IBAction func joinGroupButton(_ sender: Any) {
        
    }
    

    @objc func displayMarkers() {
        for aCourse in Data.sharedInstance.courses {
            for aGroup in aCourse.groups {
                let courseLat = aGroup.location_lat
                let courseLong = aGroup.location_lon
                let position = CLLocationCoordinate2D(latitude: courseLat, longitude: courseLong)
                let marker = GMSMarker(position: position)
                marker.title = aGroup.course.title
                marker.map = mapView
                
            }
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

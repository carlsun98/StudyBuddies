//
//  CreateGroupThirdVCTableViewController.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/17/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import UIKit
import GoogleMaps

class CreateGroupThirdVCTableViewController: UITableViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapContainerView: UIView!
    var groupMarker: GMSMarker? = nil
    var mapView: GMSMapView? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        let mapFrame = CGRect(x: 0, y: 0, width: mapContainerView.frame.width, height: mapContainerView.frame.height)
        let camera = GMSCameraPosition.camera(withLatitude: 40.3440, longitude: -74.6514, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: mapFrame, camera: camera)
        mapView!.delegate = self
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        //marker.map = mapView
        
        mapContainerView.addSubview(mapView!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let mapFrame = CGRect(x: 0, y: 0, width: mapContainerView.frame.width, height: mapContainerView.frame.height)
        mapView!.frame = mapFrame
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        let marker = GMSMarker()
        marker.position = coordinate
        marker.title = "Study Group Here"
        marker.snippet = "Your study group will be here"
        marker.map = mapView
        mapView.selectedMarker = marker
        mapView.animate(toLocation: coordinate)
        mapView.animate(toZoom: 17.0)
        groupMarker = marker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

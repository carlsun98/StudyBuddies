//
//  Group.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import Foundation

class Group {
    var id: Int
    var size: Int
    var starttime: Date
    var endtime: Date
    var leader_id: Int
    var location_lat: Double
    var location_lon: Double
    var course: Course
    var category: String
    var description: String
    var locationDescription: String
    
    init () {
        id = 0
        size = 1
        starttime = Date()
        endtime = Date()
        leader_id = 0
        location_lat = 0.0
        location_lon = 0.0
        course = Course()
        category = ""
        description = ""
        locationDescription = ""
    }
}

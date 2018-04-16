//
//  School.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import Foundation

class School {
    
    var id: Int
    var location_lat: Double
    var location_lon: Double
    var school_courses: Array<Course>
    
    init () {
        id = 0
        location_lat = 0.0
        location_lon = 0.0
        school_courses = []
    }
}

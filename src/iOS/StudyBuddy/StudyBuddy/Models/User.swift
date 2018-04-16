//
//  User.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import Foundation

class User {
    
    var id: Int
    var followed_courses: Array<Course>
    var name: String
    var class_year: Int
    var email: String
    var group: Group?
    
    init () {
        id = 0
        followed_courses = []
        name = ""
        class_year = 1
        email = ""
        group = nil
    }
}

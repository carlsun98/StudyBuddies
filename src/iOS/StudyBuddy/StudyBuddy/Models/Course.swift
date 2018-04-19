//
//  Course.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import Foundation


class Course {
    
    var groups: Array<Group>
    var abbrv: String
    var number: String
    var title: String
    var id: Int
    
    init () {
        groups = []
        abbrv = ""
        number = ""
        title = ""
        id = 0
    }
}

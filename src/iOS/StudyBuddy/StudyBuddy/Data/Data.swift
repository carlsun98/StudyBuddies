//
//  Data.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import Foundation

final class Data {
    public var sessionToken: String = ""
    static let sharedInstance = Data()
    public var courses: Array<Course> = []
    public var school: School = School()
    public var currentGroup = Group()
    
    public func fetchClasses(succeed: @escaping successCallback, error: @escaping errorCallback, failure: @escaping failureCallback) {
        let url = Network2.sharedInstance.getURLForAPI(kUserClasses)
        Network2.sharedInstance.sendRequestToURL(url: url, parameters: ["session_token": sessionToken], success: { (response: Any?) in
            let data = response as! Array<Dictionary<String, Any>>
            let success = data[0]["success"] as! Int
            if (success == 1) {
                let classData = data[1]["classes"] as! Array<Dictionary<String, Any>>
                self.courses = []
                for course in classData {
                    let newCourse = Course()
                    newCourse.abbrv = course["course_abbreviation"] as! String
                    newCourse.number = course["course_number"] as! String
                    newCourse.title = course["course_title"] as! String
                    newCourse.id = course["id"] as! Int
                    let activeGroupsData = course["active_groups"] as! Array<Dictionary<String,Any>>
                    var groups: Array<Group> = []
                    for groupData in activeGroupsData {
                        let group = Group()
                        group.id = groupData["id"] as! Int
                        group.category = groupData["category"] as! String
                        group.starttime = Date() //groupData["start_time"]
                        group.endtime = Date()
                        group.leader_id = groupData["leader_id"] as! Int
                        group.location_lat = groupData["location_lat"] as! Double
                        group.location_lon = groupData["location_lon"] as! Double
                        group.description = groupData["description"] as! String
                        group.locationDescription = "" //groupData["location_description"] as! String
                        group.size = 1 //groupData["size"] as! Int
                        group.course = newCourse
                        groups.append(group)
                    }
                    newCourse.groups = groups
                    self.courses.append(newCourse)
                }
                succeed(self.courses)
            } else {
                let errorMessage = data[0]["message"] as! String
                error(errorMessage)
            }
        }) { (error: Error) in
            failure(error)
        }
    }
    private init() {
    }
}

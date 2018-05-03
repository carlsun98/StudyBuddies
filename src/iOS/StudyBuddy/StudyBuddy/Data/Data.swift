//
//  Data.swift
//  StudyBuddy
//
//  Created by Ajay Penmatcha on 4/15/18.
//  Copyright © 2018 StudyBuddies LLC. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let dataLoaded = Notification.Name("dataLoaded")
    static let currentGroupChanged = Notification.Name("groupChanged")
}

final class Data {
    public var sessionToken: String = ""
    static let sharedInstance = Data()
    public var courses: Array<Course> = []
    public var school: School = School()
    public var currentGroup: Group? = nil
    
    public func getCurrentGroup(succeed: @escaping successCallback, error: @escaping errorCallback, failure: @escaping failureCallback) {
        let url = Network2.sharedInstance.getURLForAPI(kGetCurrentGroupApi)
        Network2.sharedInstance.sendRequestToURL(url: url, parameters: ["session_token": sessionToken], success: { (response: Any?) in
            let data = response as! Array<Dictionary<String, Any>>
            let success = data[0]["success"] as! Int
            if (success == 1) {
                let group_data = data[1]["group"] as! Dictionary<String, Any>
                let group_id = group_data["id"] as! Int
                if (group_id == -1) {
                    Data.sharedInstance.currentGroup = nil
                } else {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    let group = Group()
                    group.id = group_data["id"] as! Int
                    group.category = group_data["category"] as! String
                    group.starttime = dateFormatter.date(from: group_data["start_time"] as! String)!
                    group.endtime = dateFormatter.date(from: group_data["end_time"] as! String)!
                    group.leader_id = group_data["leader_id"] as! Int
                    group.location_lat = group_data["location_lat"] as! Double
                    group.location_lon = group_data["location_lon"] as! Double
                    group.description = group_data["description"] as! String
                    group.locationDescription = group_data["location_description"] as! String
                    group.size = group_data["size"] as! Int
                    let course_data = group_data["course"] as! Dictionary<String, Any>
                    let course = Course()
                    course.name = course_data["course_name"] as! String
                    course.title = course_data["course_title"] as! String
                    course.id = course_data["id"] as! Int
                    group.course = course
                    Data.sharedInstance.currentGroup = group
                }
                NotificationCenter.default.post(name: .currentGroupChanged, object: nil)
                succeed(nil)
            }
        }) { (error: Error) in
            failure(error)
        }
    }
    
    public func fetchClasses(succeed: @escaping successCallback, error: @escaping errorCallback, failure: @escaping failureCallback) {
        let url = Network2.sharedInstance.getURLForAPI(kUserClasses)
        Network2.sharedInstance.sendRequestToURL(url: url, parameters: ["session_token": sessionToken], success: { (response: Any?) in
            let data = response as! Array<Dictionary<String, Any>>
            let success = data[0]["success"] as! Int
            if (success == 1) {
                let classData = data[1]["classes"] as! Array<Dictionary<String, Any>>
                self.courses = []
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                for course in classData {
                    let newCourse = Course()
                    newCourse.name = course["course_name"] as! String
                    newCourse.title = course["course_title"] as! String
                    newCourse.id = course["id"] as! Int
                    let activeGroupsData = course["active_groups"] as! Array<Dictionary<String,Any>>
                    var groups: Array<Group> = []
                    for groupData in activeGroupsData {
                        let group = Group()
                        group.id = groupData["id"] as! Int
                        group.category = groupData["category"] as! String
                        group.starttime = dateFormatter.date(from: groupData["start_time"] as! String)!
                        group.endtime = dateFormatter.date(from: groupData["end_time"] as! String)!
                        group.leader_id = groupData["leader_id"] as! Int
                        group.location_lat = groupData["location_lat"] as! Double
                        group.location_lon = groupData["location_lon"] as! Double
                        group.description = groupData["description"] as! String
                        group.locationDescription = groupData["location_description"] as! String
                        group.size = groupData["size"] as! Int
                        group.course = newCourse
                        groups.append(group)
                    }
                    newCourse.groups = groups
                    self.courses.append(newCourse)
                }
                NotificationCenter.default.post(name: .dataLoaded, object: nil)
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

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
    public var classes: Array<Course> = []
    public var school: School = School()
    public var currentGroup = Group()
    
    public func fetchClasses(succeed: @escaping successCallback, failure: @escaping failureCallback) {
        let url = Network2.sharedInstance.getURLForAPI(kUserClasses)
        Network2.sharedInstance.sendRequestToURL(url: url, parameters: ["session_token": sessionToken], success: { (response: Any?) in
            let data = response as! Array<Dictionary<String, Any>>
            let success = data[0]["success"] as! Int
            if (success == 1) {
                let classData = data[1]["classes"] as! Array<Dictionary<String, Any>>
                self.classes = []
                for course in classData {
                    let newCourse = Course()
                    newCourse.abbrv = course["course_abbreviation"] as! String
                    newCourse.number = course["course_number"] as! String
                    newCourse.title = course["course_title"] as! String
                    newCourse.id = course["id"] as! Int
                    self.classes.append(newCourse)
                }
                succeed(self.classes)
            }
        }) { (error: Error) in
            failure(error)
        }
    }
    private init() {
    }
}

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
    private init() {}
}

//
//  Users.swift
//  TraumJobs
//
//  Created by Eggenschwiler Andre on 16.09.24.
//

import Foundation
import SwiftData


class User : Identifiable {
    var id = UUID()
    var userName: String
    var userEmail: String
    var birthday: String
    var location: String
    var notification: Bool
    var language: String
    var darkmode: Bool
    var fontsize: Int
    
    init(id: UUID = UUID(), userName: String, userEmail: String, birthday: String, location: String, notification: Bool, language: String, darkmode: Bool, fontsize: Int) {
        self.id = id
        self.userName = userName
        self.userEmail = userEmail
        self.birthday = birthday
        self.location = location
        self.notification = notification
        self.language = language
        self.darkmode = darkmode
        self.fontsize = fontsize
    }
    
}

//
//  Skill.swift
//  TraumJobs
//
//  Created by Eggenschwiler Andre on 19.09.24.
//


import SwiftUI
import Foundation
import SwiftData

@Model
class Skill: Identifiable {
    var id: UUID = UUID()
    var titel: String
    
    var jobs: [Job] = []
    
    init(titel: String) {
        self.titel = titel
       
    }
}




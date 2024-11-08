//
//  Job.swift
//  TraumJobs
//
//  Created by Eggenschwiler Andre on 16.09.24.
//
import SwiftUI
import Foundation
import SwiftData

@Model
class Job : Identifiable {
    var id: UUID = UUID()
    var titel: String
    var details: String
    var salary: Double
    var favorite: Bool
    var imageName: String?
    var date: Date
    
    @Relationship(deleteRule: .cascade, inverse: \Skill.jobs)
    var skills: [Skill]
    
    
    
    init(titel: String, details: String, salary: Double, favorite: Bool, imageName: String? = nil, skills: [Skill]) {
        self.titel = titel
        self.details = details
        self.salary = salary
        self.skills = skills
        self.favorite = favorite
        self.imageName = imageName
        self.date = Date()
    }
}





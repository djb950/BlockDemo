//
//  Employee.swift
//  BlockDemo
//
//  Created by DJ A on 3/20/23.
//

import Foundation

struct Employee: Hashable, Identifiable, Codable {
    var id: UUID
    
    var name: String
    var phoneNumber: String
    var email: String
    var biography: String
    var photoURLSmall: URL
    var photoURLLarge: URL
    var team: String
    var employeeType: String
}

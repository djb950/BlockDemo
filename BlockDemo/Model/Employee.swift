//
//  Employee.swift
//  BlockDemo
//
//  Created by DJ A on 3/20/23.
//

import Foundation

struct Employee: Hashable, Identifiable, Codable {
    var id: String
    
    var name: String
    var phoneNumber: String
    var email: String
    var biography: String
    var photoURLSmall: URL
    var photoURLLarge: URL
    var team: String
    var employeeType: String
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name = "full_name"
        case phoneNumber = "phone_number"
        case email = "email_address"
        case biography = "biography"
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case team = "team"
        case employeeType = "employee_type"
    }
}

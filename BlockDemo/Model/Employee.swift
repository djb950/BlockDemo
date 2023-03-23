//
//  Employee.swift
//  BlockDemo
//
//  Created by DJ A on 3/20/23.
//

import Foundation

enum EmployeeType: String, Codable {
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
    case unknown = "UNKNOWN"
    
    var rowText: String {
        switch self {
        case .fullTime:
            return "Full Time"
        case .partTime:
            return "Part Time"
        case .contractor:
            return "Contractor"
        case .unknown:
            return "Unknown"
        }
    }
}

struct Employee: Hashable, Identifiable, Codable {
    var id: String
    
    var name: String
    var phoneNumber: String
    var email: String
    var biography: String
    var photoURLSmall: URL?
    var photoURLLarge: URL?
    var team: String
    var employeeType: EmployeeType
    
    /// This init handles cases where data is malformed by providing a default value if one is not returned from the API
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? "N/A"
//        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "Unknown"
//        self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber) ?? "N/A"
//        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? "N/A"
//        self.biography = try container.decodeIfPresent(String.self, forKey: .biography) ?? "N/A"
//        self.photoURLSmall = try container.decodeIfPresent(URL.self, forKey: .photoURLSmall) ?? nil
//        self.photoURLLarge = try container.decodeIfPresent(URL.self, forKey: .photoURLLarge) ?? nil
//        self.team = try container.decodeIfPresent(String.self, forKey: .team) ?? "N/A"
//        self.employeeType = try container.decodeIfPresent(EmployeeType.self, forKey: .employeeType) ?? .unknown
//    }
    
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

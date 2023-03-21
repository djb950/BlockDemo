//
//  NetworkService.swift
//  BlockDemo
//
//  Created by DJ A on 3/20/23.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case emptyData
    case serverError
    case unknown
    
    var errorMessage: String {
        switch self {
        case .badRequest:
            return "There was an error with your request, please try again"
        case .emptyData:
            return "No data returned for request"
        case .serverError:
            return "Server error, please try again"
        case .unknown:
            return "An unknown error occurred, please try again."
        }
    }
}

struct EmployeesAPIResponse: Codable {
    var employees: [Employee]
}

protocol NetworkProtocol {
    func fetchEmployees() async throws -> [Employee]
}

class NetworkService: NetworkProtocol {
    var url: URL = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json")!
    
    /// Asynchronously fetches employees from the Block demo API.
    /// - Returns: an array containing `Employee` objects.
    /// - Throws: `NetworkError` if request failed
    func fetchEmployees() async throws -> [Employee] {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 200:
                let results = try JSONDecoder().decode(EmployeesAPIResponse.self, from: data)
                return results.employees
            case 400...499:
                throw NetworkError.badRequest
            case 500...599:
                throw NetworkError.serverError
            default:
                throw NetworkError.unknown
            }
        } else {
            throw NetworkError.unknown
        }
    }
}

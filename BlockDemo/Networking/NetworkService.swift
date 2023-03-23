//
//  NetworkService.swift
//  BlockDemo
//
//  Created by DJ A on 3/20/23.
//

import Foundation

enum NetworkError: Error, Comparable {
    case badRequest
    case serverError
    case unknown
    
    var errorMessage: String {
        switch self {
        case .badRequest:
            return "There was an error with your request, please try again"
        case .serverError:
            return "Server error, please try again"
        case .unknown:
            return "An unknown error occurred, please try again."
        }
    }
}

enum TestURL {
    case standard
    case malformedData
    case emptyData
    
    var url: URL {
        switch self {
        case .standard:
            return URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json")!
        case .malformedData:
            return URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json")!
        case .emptyData:
            return URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json")!
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
    /// Asynchronously fetches employees from the Block demo API.
    /// - Returns: an array containing `Employee` objects.
    /// - Throws: `NetworkError` if request failed
    func fetchEmployees() async throws -> [Employee] {
        var request = URLRequest(url: TestURL.standard.url)
        request.httpMethod = "GET"
        let (data, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 200:
                do {
                    let results = try JSONDecoder().decode(EmployeesAPIResponse.self, from: data)
                    return results.employees
                } catch {
                    // if data is malformed, invalidate entire list of employees
                    return []
                }
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

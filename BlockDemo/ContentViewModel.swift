//
//  ContentViewModel.swift
//  BlockDemo
//
//  Created by DJ A on 3/20/23.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var employees: [Employee]?
    let networkService: NetworkProtocol
    
    init(networkService: NetworkProtocol) {
        self.networkService = networkService
    }
    
    /// Uses `NetworkService` to make a call to the Block employee API.
    func fetchEmployees()  {
        Task {
            do {
                let employees = try await networkService.fetchEmployees()
                await MainActor.run {
                    self.employees = employees
                }
            } catch(let error as NetworkError)  {
                print("Error fetching employees: \(error.errorMessage)")
            }
        }
        

    }
}

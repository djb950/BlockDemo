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
    
    func fetchEmployees() async {
        do {
            let employees = try await networkService.fetchEmployees()
            self.employees = employees
        } catch(let error) {
            print("Error fetching employees: \(error)")
        }

    }
}
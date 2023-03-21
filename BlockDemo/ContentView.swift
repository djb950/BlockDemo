//
//  ContentView.swift
//  BlockDemo
//
//  Created by DJ A on 3/20/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel
    
    init(networkService: NetworkProtocol) {
        _viewModel = StateObject(wrappedValue: ContentViewModel(networkService: networkService))
    }
    
    var body: some View {
        NavigationStack {
            List {
                // If we have employees
                if let employees = viewModel.employees, !employees.isEmpty {
                    ForEach(employees, id: \.self) { employee in
                        EmployeeListRow(employee: employee)
                    }
                    .onDelete { deletedEmployee in
                        
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 20)
                            .shadow(radius: 0.2)
                            .background(.clear)
                            .foregroundColor(.white)
                            .padding(
                                EdgeInsets(
                                    top: 5,
                                    leading: 10,
                                    bottom: 5,
                                    trailing: 10
                                )
                            )
                    )
                    .listRowSeparator(.hidden)
                } else {
                    // Empty State
                    VStack {
                        Image(systemName: "person.3.fill")
                            .resizable()
                            .frame(width: 100, height: 65)
                            .foregroundColor(.purple)
                            .shadow(radius: 1, x: 1, y: 1)
                        Text("No employees yet. Drag down to try again.")
                            .font(.system(size: 16, weight: .thin))
                    }
                }
            }
            .animation(.default, value: viewModel.employees)
            .refreshable {
                viewModel.fetchEmployees()
            }
            .task {
                viewModel.fetchEmployees()
            }
            .navigationTitle("Employees")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(networkService: NetworkService())
    }
}

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
                ForEach(viewModel.employees ?? [], id: \.self) { employee in
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
            }
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

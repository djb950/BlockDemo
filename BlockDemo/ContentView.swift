//
//  ContentView.swift
//  BlockDemo
//
//  Created by DJ A on 3/20/23.
//

import SwiftUI

enum SortSelection: CaseIterable {
    case name
    case team
    case type
    
    var buttonTitle: String {
        switch self {
        case .name:
            return "Name"
        case .team:
            return "Team"
        case .type:
            return "Type"
        }
    }
    
    var employeeSortKeyPath: KeyPath<Employee, String> {
        switch self {
        case .name:
            return \Employee.name
        case .team:
            return \Employee.team
        case .type:
            return \Employee.employeeType.rowText
        }
    }
}

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel
    @State var currentSortSelection: SortSelection = .name
    
    init(networkService: NetworkProtocol) {
        _viewModel = StateObject(wrappedValue: ContentViewModel(networkService: networkService))
    }
    
    var body: some View {
        NavigationStack {
            List {
                // If we have employees
                ForEach(viewModel.employees?.sorted(by: currentSortSelection.employeeSortKeyPath) ?? [] , id: \.self) { employee in
                    EmployeeListRow(employee: employee)
                }
                .onDelete { deletedEmployee in
                    
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 20)
                        .shadow(radius: 0.2)
                        .background(.clear)
                        .foregroundColor(Colors.listRow)
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
                .listRowBackground(Color(UIColor.secondarySystemBackground))
            }
            .overlay(Group {
                if let employees = viewModel.employees, employees.isEmpty {
                    VStack(spacing: 25) {
                        Image(systemName: "person.3.fill")
                            .resizable()
                            .frame(width: 100, height: 50)
                            .foregroundColor(.purple)
                            .shadow(radius: 1, x: 1, y: 1)
                        Text("No employees yet. Drag down to try again.")
                            .font(.system(size: 16, weight: .thin))
                    }
                }
            })
            .animation(.default, value: viewModel.employees)
            .refreshable {
                viewModel.fetchEmployees()
            }
            .task {
                viewModel.fetchEmployees()
            }
            .toolbar {
                Menu {
                    ForEach(SortSelection.allCases, id: \.self) { selectionType in
                        Button {
                            menuButtonPressed(action: selectionType)
                        } label: {
                            HStack {
                                if currentSortSelection == selectionType {
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                }
                                Text(selectionType.buttonTitle)
                            }
                        }
                    }
                } label: {
                    HStack {
                        Text(currentSortSelection.buttonTitle)
                            .font(.system(size: 14))
                        Image(systemName: "arrow.up.arrow.down")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    .animation(nil, value: currentSortSelection)
                }
            }
            .navigationTitle("Employees")
        }
    }
    
    private func menuButtonPressed(action: SortSelection) {
        currentSortSelection = action
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(networkService: NetworkService())
    }
}

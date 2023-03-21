//
//  ContentView.swift
//  BlockDemo
//
//  Created by DJ A on 3/20/23.
//

import SwiftUI

struct ContentView: View {
    var employees = [
        Employee(id: UUID(), name: "John Smith", phoneNumber: "8435555555", email: "john@square.com", biography: "John is a really neat guy who works at block", photoURLSmall: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg")!, photoURLLarge: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg")!, team: "Engineering", employeeType: "Full Time"),
        Employee(id: UUID(), name: "John Smith", phoneNumber: "8435555555", email: "john@square.com", biography: "John is a really neat guy who works at block", photoURLSmall: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg")!, photoURLLarge: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg")!, team: "Engineering", employeeType: "Full Time"),
        Employee(id: UUID(), name: "John Smith", phoneNumber: "8435555555", email: "john@square.com", biography: "John is a really neat guy who works at block", photoURLSmall: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg")!, photoURLLarge: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg")!, team: "Engineering", employeeType: "Full Time"),
        Employee(id: UUID(), name: "John Smith", phoneNumber: "8435555555", email: "john@square.com", biography: "John is a really neat guy who works at block", photoURLSmall: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg")!, photoURLLarge: URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg")!, team: "Engineering", employeeType: "Full Time"),
    ]
    
    var body: some View {
        List {
            ForEach(employees, id: \.self) { employee in
                EmployeeListRow(employee: employee)
            }
            .onDelete { deletedEmployee in
                
            }
            .listRowBackground(
                RoundedRectangle(cornerRadius: 20)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

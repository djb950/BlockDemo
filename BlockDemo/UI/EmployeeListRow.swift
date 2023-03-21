//
//  EmployeeListRow.swift
//  BlockDemo
//
//  Created by DJ A on 3/20/23.
//

import SwiftUI

struct EmployeeListRow: View {
    // photo
    // name
    // team
    var employee: Employee
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Circle()
                    .foregroundColor(.purple)
                    .frame(width: 50, height: 50)
                    .shadow(radius: 0.4, x: 1, y: 1)
                VStack(alignment: .leading) {
                    Text(employee.name)
                        .font(.system(size: 14, weight: .bold))
                        .padding(.bottom, 1)
                    Text(employee.email)
                        .padding(.bottom, 1)
                        .font(.system(size: 12, weight: .thin))
                    Text(employee.phoneNumber)
                        .font(.system(size: 12, weight: .thin))
                    Spacer()
                    
                }
                .padding(.leading, 2)
            }
            .padding(
                EdgeInsets(
                    top: 15,
                    leading: 5,
                    bottom: 15,
                    trailing: 5
                )
                    )
            .foregroundColor(.gray)
            HStack {
                Spacer()
                VStack {
                    Text("Team")
                        .padding(.bottom, 1)
                        .font(.system(size: 12, weight: .bold))
                    Text(employee.team)
                        .font(.system(size: 10, weight: .thin))
                }
                Spacer()
                Divider()
                    .padding([.top, .bottom], 5)
                Spacer()
                VStack {
                    Text("Type")
                        .padding(.bottom, 1)
                        .font(.system(size: 12, weight: .bold))
                    Text(employee.employeeType)
                        .font(.system(size: 10, weight: .thin))
                }
                Spacer()
            }
            .foregroundColor(.gray)
        }
    }
}

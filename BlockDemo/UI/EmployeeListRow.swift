//
//  EmployeeListRow.swift
//  BlockDemo
//
//  Created by DJ A on 3/20/23.
//

import SwiftUI
import CachedAsyncImage

struct EmployeeListRow: View {
    var employee: Employee
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                CachedAsyncImage(url: employee.photoURLSmall) { image in
                    image.resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                } placeholder: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
                .shadow(radius: 1, x: 0, y: 2)
                VStack(alignment: .leading) {
                    Text(employee.name)
                        .font(.system(size: 14, weight: .bold))
                        .padding(.bottom, 1)
                    HStack {
                        Image(systemName: "envelope")
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: 12, height: 10)
                        Text(employee.email)
                            .padding(.bottom, 1)
                            .font(.system(size: 12, weight: .thin))
                    }
                    
                    HStack {
                        Image(systemName: "phone")
                            .resizable()
                            .foregroundColor(.green)
                            .frame(width: 12, height: 12)
                        Text(employee.phoneNumber.toPhoneNumber())
                            .font(.system(size: 12, weight: .thin))
                    }
                    Spacer()
                }
                .padding(.leading, 2)
            }
            .padding(
                EdgeInsets(
                    top: 15,
                    leading: 5,
                    bottom: 5,
                    trailing: 5
                )
                    )
            .foregroundColor(.gray)
            HStack(alignment: .center) {
                VStack {
                    Text("Team")
                        .padding(.bottom, 1)
                        .font(.system(size: 12, weight: .bold))
                    Text(employee.team)
                        .font(.system(size: 10, weight: .thin))
                        .multilineTextAlignment(.center)
                }
                .padding(.leading, 35)
                .frame(maxWidth: .infinity)
                Divider()
                    .padding([.top, .bottom], 5)
                    .frame(maxWidth: .infinity)
                VStack {
                    Text("Type")
                        .padding(.bottom, 1)
                        .font(.system(size: 12, weight: .bold))
                    Text(employee.employeeType.rowText)
                        .font(.system(size: 10, weight: .thin))
                }
                .padding(.trailing, 35)
                .frame(maxWidth: .infinity)
            }
            .foregroundColor(.gray)
        }
        .padding(.bottom, 5)
    }
}

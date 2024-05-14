//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//


import SwiftUI

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode    //控制视图的显示和隐藏
    
    let name = UserDefaults.standard.string(forKey: "name") ?? "User"     //读取用户名字
    let email = UserDefaults.standard.string(forKey: "email") ?? "user@example.com"     //读取用户email
    
    var body: some View {
        NavigationView {       //嵌套导航视图
            VStack(spacing: 20) {
                Image("person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 4)
                    )
                    .shadow(radius: 10)
                
                Text(name)
                    .font(.title)
                    .foregroundColor(.primary)
                
                Text(email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Divider()
                
                NavigationLink(destination: ViewBookingListView()) {     //点击导航至ViewBookingListView
                    Text("View Bookings")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue, Color.indigo]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Log Out")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.vertical, 15)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .navigationBarTitle("Account", displayMode: .inline)
            .navigationBarItems(trailing: EditButton())
        }
    }
}

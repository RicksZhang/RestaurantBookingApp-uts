//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//


import SwiftUI

struct AccountView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let name = UserDefaults.standard.string(forKey: "name") ?? "User"
    let email = UserDefaults.standard.string(forKey: "email") ?? "user@example.com"
    
    var body: some View {
        NavigationView {
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
                
                NavigationLink(destination: ViewBookingListView()) {
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

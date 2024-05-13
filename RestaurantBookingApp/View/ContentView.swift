//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//

import SwiftUI

struct Item: Identifiable {
    var id = UUID()
    var imageName: String
    var title: String
    var foodImagelist:[String]
    var pricelist:[Int]
    var foodname:[String]
}

struct ContentView: View {
    let items: [Item] = [
        Item(imageName: "r1", title: "KIDS-FRIENDLY RESTAURANT",foodImagelist:["1","2","3","4","5","6","10","7","8","9","11","12"],pricelist: [20,30,10,10,20,30,40,10,20,30,40,50], foodname: ["Cheeseburger","Fried Chicken Burger","Vegetarian Burger","Ham and Cheese Burger","Salmon Sushi","Tuna Sushi","Pancake","Unagi Sushi","Nori Maki","Kimchi","Sauerkraut","Tsukemono"]),
        Item(imageName: "r2", title: "MONTHER'S DAY SPECIAL",foodImagelist:["4","5","6","10"],pricelist:[10,20,30,40], foodname: ["Ham and Cheese Burger","Salmon Sushi","Tuna Sushi","Pancake"]),
        Item(imageName: "r3", title: "MOUSSET WINE PAIRING DINNER",foodImagelist:["7","8","9","11","12"],pricelist:[10,20,30,40,50], foodname: ["Unagi Sushi","Nori Maki","Kimchi","Sauerkraut","Tsukemono"])
    ]
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                List(items) { item in
                    NavigationLink(destination: RestaurantView(item: item)) {
                        HStack {
                            Image(item.imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                                .padding(.vertical, 5)
                                .padding(.leading, 10)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(item.title)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                
                                Text("Explore delicious food options")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 10)
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Grab a Seat").foregroundColor(Color(red: 0.9, green: 0.5, blue: 0.4))
                .navigationBarTitleDisplayMode(.large)
            }
            .tabItem {
                Image(systemName: "list.dash")
                Text("Book")
            }
            .tag(0)
            
            FoodListView()
                .tabItem {
                    Image(systemName: "shippingbox")
                    Text("Food")
                }
                .tag(1)
            
            ShoppingCartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
                .tag(2)
            
            OrderTrackingView()
                .tabItem {
                    Image(systemName: "checkmark")
                    Text("Track Order")
                }
                .tag(3)
            
            AccountView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(4)
        }
        .accentColor(.blue)
        .navigationBarBackButtonHidden(true)
    }
}

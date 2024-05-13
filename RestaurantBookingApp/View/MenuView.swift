//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//

import SwiftUI
 
struct MenuItemRow: View {
    @Binding var item: FoodItem
    var addToCart: (FoodItem) -> Void
    @State private var showingDetail = false
    
    var body: some View {
        HStack {
            Image(item.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text("$\(item.price)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            

            Button(action: {
                           showingDetail = true
                       }) {
                           Image(systemName: "info.circle")
                               .imageScale(.large)
                               .foregroundColor(.blue)
                       }
                       .sheet(isPresented: $showingDetail) {
                           ProductDetailsView(product: FoodItem(name: item.name, price: item.price, image: item.image, quantity: item.quantity))
                         
                       }
            
            
            
            
            
        }
        .padding()
        .navigationTitle("Food Shop")
    }
    
}

// MenuView
struct MenuView: View {
    @State var menuItems: [FoodItem]
    var addToCart: (FoodItem, Int) -> Void
    
    var body: some View {
        NavigationView {
            List {
                ForEach(menuItems.indices, id: \.self) { index in
                    MenuItemRow(item: $menuItems[index], addToCart: { item in
                        self.addToCart(item, item.quantity)
                    })
                }
            }
        }
       
    }
}


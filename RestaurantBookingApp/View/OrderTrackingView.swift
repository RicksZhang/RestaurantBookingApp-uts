//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//

import SwiftUI



struct OrderTrackingView: View {
    @EnvironmentObject var purchaseRecord: PurchaseRecord
    
    var body: some View {
        NavigationView {
            List(purchaseRecord.orders) { order in
                OrderCardView(order: order)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Order Tracking")
            .onAppear {
                printAllPurchaseRecords()
            }
        }
    }
    
    func printAllPurchaseRecords() {
        for order in purchaseRecord.orders {
            print("ID: \(order.id), Date: \(order.date), Name: \(order.name), Quantity: \(order.quantity), Price: \(order.price), Image: \(order.image)")
        }
    }
}

struct OrderCardView: View {
    let order: OrderItem
    
    var body: some View {
        HStack(spacing: 16) {
            Image(order.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(order.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("Quantity: \(order.quantity)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("$\(Int(order.price * Double(order.quantity)))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(order.date)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

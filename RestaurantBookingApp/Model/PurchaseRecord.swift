//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//


import SwiftUI
import Foundation

class PurchaseRecord: ObservableObject {
    @Published var orders: [OrderItem] = []
}

struct OrderItem: Identifiable {
    var id: String
    var date: String
    var name: String
    var quantity: Int
    var price: Double
    var image: String 
}

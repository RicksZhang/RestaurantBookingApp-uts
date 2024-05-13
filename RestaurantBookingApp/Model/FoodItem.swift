//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//


import Foundation

// Food item model
struct FoodItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Int
    let image: String
    var quantity: Int 
}


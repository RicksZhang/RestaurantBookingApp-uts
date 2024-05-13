//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//


import SwiftUI

import Foundation

class ShoppingCartManagement: ObservableObject {
    @Published var products: [FoodItem] = []
    
    func addProduct(name: String, price: Int, quantity: Int, image: String) {
        let newProduct = FoodItem(name: name, price: price, image: image, quantity: quantity)
        products.append(newProduct)
    }

    func removeProduct(at index: Int) {
        products.remove(at: index)
    }

    func clearCart() {
        products = []
    }
}

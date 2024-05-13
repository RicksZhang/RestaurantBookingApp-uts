//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//

import SwiftUI

struct ShoppingCartView: View {
    @EnvironmentObject var cartManager: ShoppingCartManagement
    @State private var isAlertShown = false
    @EnvironmentObject var purchaseRecord: PurchaseRecord

    var body: some View {
        NavigationView {
            VStack {
                if cartManager.products.isEmpty {
                    Spacer()
                    Text("Your cart is empty")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    cartItemsList
                    purchaseSection
                }
            }
            .navigationTitle("Shopping Cart")
            .alert(isPresented: $isAlertShown) {
                Alert(
                    title: Text("Purchase Confirmed"),
                    message: Text("Thank you for your purchase!"),
                    dismissButton: .default(Text("OK")) {
                        cartManager.clearCart()
                    }
                )
            }
        }
    }

    private var cartItemsList: some View {
        List {
            ForEach(cartManager.products.indices, id: \.self) { index in
                let product = cartManager.products[index]
                CartItemView(product: product, removeAction: {
                    cartManager.removeProduct(at: index)
                })
            }
        }
        .listStyle(PlainListStyle())
    }

    private var purchaseSection: some View {
        VStack(spacing: 16) {
            Text("Total Cost: $\(totalPrice)")
                .font(.title2)
                .foregroundColor(.primary)

            Button(action: handlePurchase) {
                Text("Checkout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.mint]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }

    private func handlePurchase() {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: currentDate)

        for product in cartManager.products {
            let productID = product.id.uuidString.prefix(6)
            let orderItem = OrderItem(
                id: String(productID),
                date: dateString,
                name: product.name,
                quantity: product.quantity,
                price: Double(product.price),
                image: product.image
            )
            purchaseRecord.orders.append(orderItem)
        }

        isAlertShown = true
        cartManager.clearCart()
        print("Completing purchase...")
    }

    private var totalPrice: Int {
        cartManager.products.reduce(0) { $0 + ($1.price * $1.quantity) }
    }
}

struct CartItemView: View {
    let product: FoodItem
    let removeAction: () -> Void

    var body: some View {
        HStack(spacing: 16) {
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)

            VStack(alignment: .leading, spacing: 4) {
                Text(product.name)
                    .font(.headline)
                Text("Qty: \(product.quantity)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("Price: $\(product.price)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Button(action: removeAction) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .font(.title2)
            }
        }
        .padding(.vertical, 8)
    }
}

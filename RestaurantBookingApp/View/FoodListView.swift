//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//


import SwiftUI

class ShoppingCartManager: ObservableObject {
    @Published var cartItems: [FoodItem] = []
    
    func addToCart(_ item: FoodItem, quantity: Int) {
        for _ in 0..<quantity {
            cartItems.append(item)
        }
    }
    
    func removeFromCart(_ item: FoodItem) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems.remove(at: index)
        }
    }
    
    func clearCart() {
        cartItems.removeAll()
    }
}

struct FoodListView: View {
    @StateObject private var cartManager = ShoppingCartManager()
    @EnvironmentObject var purchaseRecord: PurchaseRecord
    @State private var showingCart = false
    @State private var searchText = ""
    
    let menu = [
        FoodItem(name: "Burger1", price: 12, image: "1", quantity: 1),
        FoodItem(name: "Burger2", price: 15, image: "2", quantity: 1),
        FoodItem(name: "Burger3", price: 8, image: "3", quantity: 1),
        FoodItem(name: "Burger4", price: 4, image: "4", quantity: 1),
        FoodItem(name: "Grilled Salmon", price: 18, image: "5", quantity: 1),
        FoodItem(name: "Sushi1", price: 10, image: "6", quantity: 1),
        FoodItem(name: "Sushi2", price: 14, image: "7", quantity: 1)
    ]
    
    var filteredMenu: [FoodItem] {
        if searchText.isEmpty {
            return menu
        } else {
            return menu.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                
                List(filteredMenu) { item in
                    MenuItemView(item: item, addToCart: cartManager.addToCart)
                }
                .listStyle(PlainListStyle())
                .listRowBackground(Color(UIColor.systemBackground))
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showingCart = true
                    }) {
                        Image(systemName: "cart")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(
                                Circle()
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [Color.green, Color.mint]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                            )
                            .overlay(
                                Text("\(cartManager.cartItems.count)")
                                    .font(.caption2)
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .background(Circle().fill(Color.red))
                                    .offset(x: 10, y: -10)
                            )
                    }
                    .padding(.trailing)
                }
            }
            .navigationBarTitle("Delicacies", displayMode: .large)
            .sheet(isPresented: $showingCart) {
                ShoppingCartFoodView()
                    .environmentObject(cartManager)
            }
        }
    }
}


struct MenuItemView: View {
    let item: FoodItem
    let addToCart: (FoodItem, Int) -> Void
    
    @State private var quantity: Int = 1
    @State private var isAnimating = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(item.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(item.name)
                    .font(.title2)
                    .foregroundColor(.primary)
                
                Text("$\(item.price)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Stepper("Quantity: \(quantity)", value: $quantity, in: 1...10)
                    .padding(.vertical, 8)
                
                Button(action: {
                                    addToCart(item, quantity)
                                    withAnimation {
                                        isAnimating = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            withAnimation {
                                                isAnimating = false
                                            }
                                        }
                                    }
                                }) {
                    Text("Add to Cart")
                                           .foregroundColor(.white)
                                           .padding(.horizontal, 16)
                                           .padding(.vertical, 8)
                                           .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .leading, endPoint: .trailing))
                                           .cornerRadius(10)
                                           .scaleEffect(isAnimating ? 1.2 : 1.0)
                                                                   .rotationEffect(isAnimating ? .degrees(360) : .degrees(0))
                                                                   .opacity(isAnimating ? 0.5 : 1.0)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Search food...", text: $text)
                .foregroundColor(.primary)
        }
        .padding(8)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}


struct ShoppingCartFoodView: View {
    @EnvironmentObject var cartManager: ShoppingCartManager
    @EnvironmentObject var purchaseRecord: PurchaseRecord
    
    var body: some View {
        NavigationView {
            VStack {
                if cartManager.cartItems.isEmpty {
                    Spacer()
                    Text("Your cart is empty")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    List(cartManager.cartItems) { item in
                        CartItemView(item: item)
                    }
                    .listStyle(PlainListStyle())
                    
                    Spacer()
                    
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
            }
            .navigationTitle("Shopping Cart")
            .alert(isPresented: $showingAlert) {
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
    
    struct CartItemView: View {
        let item: FoodItem
        @EnvironmentObject var cartManager: ShoppingCartManager
        
        var body: some View {
            HStack(spacing: 16) {
                Image(item.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.name)
                        .font(.headline)
                    Text("Qty: \(item.quantity)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("Price: $\(item.price)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: {
                    cartManager.removeFromCart(item)
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .font(.title2)
                }
            }
            .padding(.vertical, 8)
        }
    }
    
    @State private var showingAlert = false
    
    private func handlePurchase() {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = formatter.string(from: currentDate)
        
        for item in cartManager.cartItems {
            let productID = item.id.uuidString.prefix(6)
            let orderItem = OrderItem(
                id: String(productID),
                date: dateString,
                name: item.name,
                quantity: item.quantity,
                price: Double(item.price),
                image: item.image
            )
            purchaseRecord.orders.append(orderItem)
        }
        
        showingAlert = true
        cartManager.clearCart()
        print("Completing purchase...")
    }
    
    private var totalPrice: Int {
        cartManager.cartItems.reduce(0) { $0 + ($1.price * $1.quantity) }
    }
}

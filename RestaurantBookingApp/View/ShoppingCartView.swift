//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//

import SwiftUI

struct ShoppingCartView: View {
    @EnvironmentObject var cartManager: ShoppingCartManagement     //从环境中接入一个购物车管理对象，这允许视图访问和修改购物车内容
    @State private var isAlertShown = false                        //控制购买确认警告的显示状态
    @EnvironmentObject var purchaseRecord: PurchaseRecord          //记录购买历史

    var body: some View {
        NavigationView {
            VStack {
                if cartManager.products.isEmpty {     //显示购物车为空的信息
                    Spacer()
                    Text("Your cart is empty")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    cartItemsList        //列表显示购物车项
                    purchaseSection      //显示总价和结账按钮
                }
            }
            .navigationTitle("Shopping Cart")     //购买确认警告
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

    private var cartItemsList: some View {       //购物车产品列表
        List {      //遍历产品
            ForEach(cartManager.products.indices, id: \.self) { index in
                let product = cartManager.products[index]
                CartItemView(product: product, removeAction: {
                    cartManager.removeProduct(at: index)
                })
            }
        }
        .listStyle(PlainListStyle())
    }

    private var purchaseSection: some View {      //结账
        VStack(spacing: 16) {
            Text("Total Cost: $\(totalPrice)")
                .font(.title2)
                .foregroundColor(.primary)

            Button(action: handlePurchase) {       //触发handlepurchase
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

    private func handlePurchase() {    //记录购买信息，清空购物车，显示确认警告
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
            purchaseRecord.orders.append(orderItem)     //使用purchase model中的orders记录，向 purchaseRecord 中的 orders 数组添加一个新的元素 orderItem
        }

        isAlertShown = true
        cartManager.clearCart()
        print("Completing purchase...")
    }

    private var totalPrice: Int {       //价格计算方式
        cartManager.products.reduce(0) { $0 + ($1.price * $1.quantity) }
    }
}

struct CartItemView: View {       //购物车view
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

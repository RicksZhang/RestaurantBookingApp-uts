//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//

import SwiftUI



struct OrderTrackingView: View {
    @EnvironmentObject var purchaseRecord: PurchaseRecord     //注入的 PurchaseRecord 对象，所有购买订单，直接访问订单数据
    
    
    var body: some View {
        NavigationView {
            List(purchaseRecord.orders) { order in        // 显示订单列表，每个订单项使用 OrderCardView 来渲染
                OrderCardView(order: order)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Order Tracking")
            .onAppear {                                        //当视图出现时，调用 printAllPurchaseRecords函数来在控制台输出所有的购买记录
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
    let order: OrderItem                  //一个单独的订单项，包含了订单的详细信息
    
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

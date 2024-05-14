//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//

import SwiftUI
 
struct MenuItemRow: View {
    @Binding var item: FoodItem        //绑定到父视图的 FoodItem 实例。绑定允许 MenuItemRow 视图在父视图中对 item 的任何更改做出响应
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
                       .sheet(isPresented: $showingDetail) {      //showDetail被激活，显示下面信息
                           ProductDetailsView(product: FoodItem(name: item.name, price: item.price, image: item.image, quantity: item.quantity))
                         
                       }
            
            
            
            
            
        }
        .padding()
        .navigationTitle("Food Shop")
    }
    
}

// MenuView
struct MenuView: View {
    @State var menuItems: [FoodItem]      //存储食品项目列表的状态变量。
    var addToCart: (FoodItem, Int) -> Void
    
    var body: some View {
        NavigationView {
            List {      //循环遍历 menuItems 数组的索引，为每个食品项目创建一个 MenuItemRow。通过传递一个绑定到具体食品项的引用（$menuItems[index]），确保 MenuItemRow 可以显示和更新其内容
                ForEach(menuItems.indices, id: \.self) { index in
                    MenuItemRow(item: $menuItems[index], addToCart: { item in
                        self.addToCart(item, item.quantity)
                    })
                }
            }
        }
       
    }
}


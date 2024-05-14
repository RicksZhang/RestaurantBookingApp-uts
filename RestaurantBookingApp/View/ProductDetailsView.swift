//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//


import SwiftUI

struct ProductDetailsView: View {
    let product: FoodItem
    @Environment(\.presentationMode) var presentationMode   //用于管理视图的显示模式，关闭当前视图。
    @State private var quantity: Int = 1       //用户希望购买的产品数量，初始值设为1。
    @EnvironmentObject var shoppingCartManager: ShoppingCartManagement   //管理购物车的状态和操作
    
    //view布局
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                productImageSection(geometry: geo)
                
                productDetailSection(geometry: geo)
                    .background(Color.white.opacity(1))
                    .foregroundColor(.black)
                    .cornerRadius(20)
                    .offset(y: -120)
                    .ignoresSafeArea()
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)    //隐藏导航栏的返回按钮
        }
    }
    
    private func productImageSection(geometry: GeometryProxy) -> some View {   //图片展示
        Image(product.image)
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width, height: (geometry.size.height / 2) + 200)
            .ignoresSafeArea()
    }
    
    private func productDetailSection(geometry: GeometryProxy) -> some View {    //产品详情展示
        VStack(alignment: .leading, spacing: 0) {
            productNameAndPriceSection       //显示产品的名称，价格
            
            quantityAdjustmentSection      //数量调整
                .padding(.vertical)
            
            Spacer()
            
            addToCartButton          //购物车
                .padding(.bottom, 80)
        }
        .padding(.horizontal)
        .frame(width: geometry.size.width, height: (geometry.size.height / 2), alignment: .topLeading)
    }
    
    private var productNameAndPriceSection: some View {  //产品价格，名称
        VStack(alignment: .leading, spacing: 0) {
            Text(product.name)
                .font(.title)
                .fontWeight(.heavy)
                .padding(.top, 40)
            
            HStack {
                Text("$").font(.body)
                Text("\(product.price)").font(.title2).bold()
            }
            .padding(.vertical)
        }
    }
    
    private var quantityAdjustmentSection: some View {   //数量调整
        HStack {
            Button(action: decreaseQuantity) {       //减少按键
                Image(systemName: "minus").font(.title).padding()
            }

            Text("\(quantity)").font(.title)
 
            Button(action: increaseQuantity) {       //增加按键
                Image(systemName: "plus").font(.title).padding()
            }
        }
    }
    
    private var addToCartButton: some View {      //添加购物车
        Button(action: addItemToCart) {
            Text("Buy")
                .font(.body)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
    
    private func decreaseQuantity() {        //减少方法
        if quantity > 1 { quantity -= 1 }
    }
    
    private func increaseQuantity() {        //增加方法
        quantity += 1
    }
    
    private func addItemToCart() {        //调用addproduct
        shoppingCartManager.addProduct(name: product.name, price: Int(product.price), quantity: quantity, image: product.image)
        presentationMode.wrappedValue.dismiss()    //关闭视图方法
        
    }
}

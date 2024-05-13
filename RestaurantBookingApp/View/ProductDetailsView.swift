//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//


import SwiftUI

struct ProductDetailsView: View {
    let product: FoodItem
    @Environment(\.presentationMode) var presentationMode
    @State private var quantity: Int = 1
    @EnvironmentObject var shoppingCartManager: ShoppingCartManagement 
    
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
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private func productImageSection(geometry: GeometryProxy) -> some View {
        Image(product.image)
            .resizable()
            .scaledToFill()
            .frame(width: geometry.size.width, height: (geometry.size.height / 2) + 200)
            .ignoresSafeArea()
    }
    
    private func productDetailSection(geometry: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            productNameAndPriceSection
            
            quantityAdjustmentSection
                .padding(.vertical)
            
            Spacer()
            
            addToCartButton
                .padding(.bottom, 80)
        }
        .padding(.horizontal)
        .frame(width: geometry.size.width, height: (geometry.size.height / 2), alignment: .topLeading)
    }
    
    private var productNameAndPriceSection: some View {
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
    
    private var quantityAdjustmentSection: some View {
        HStack {
            Button(action: decreaseQuantity) {
                Image(systemName: "minus").font(.title).padding()
            }

            Text("\(quantity)").font(.title)

            Button(action: increaseQuantity) {
                Image(systemName: "plus").font(.title).padding()
            }
        }
    }
    
    private var addToCartButton: some View {
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
    
    private func decreaseQuantity() {
        if quantity > 1 { quantity -= 1 }
    }
    
    private func increaseQuantity() {
        quantity += 1
    }
    
    private func addItemToCart() {
        shoppingCartManager.addProduct(name: product.name, price: Int(product.price), quantity: quantity, image: product.image)
        presentationMode.wrappedValue.dismiss()
        
    }
}

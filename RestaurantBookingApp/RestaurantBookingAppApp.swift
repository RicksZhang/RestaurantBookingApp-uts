//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//


import SwiftUI
import SwiftData

@main
struct RestaurantBookingAppApp: App {
    @StateObject var s = ShoppingCartManagement()
    var purchaseRecord = PurchaseRecord()
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            RestaurantDB.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
   
    var body: some Scene {
        WindowGroup {
          LoginView()
                .environmentObject(s)
                .environmentObject(purchaseRecord)
                .modelContainer(sharedModelContainer)
                            
        }
    }
}


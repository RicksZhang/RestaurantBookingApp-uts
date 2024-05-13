//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//

import SwiftUI
import SwiftData

struct ViewBookingListView: View {
    @Query private var bookings: [RestaurantDB]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationView {
            List(bookings.filter { $0.status == "success" }, id: \.restaurantName) { booking in
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor.systemBackground))
                        .shadow(radius: 5)

                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(booking.restaurantName)
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text("Name: \(booking.name)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text("Phone: \(booking.phone)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text("Number of People: \(booking.numberofpeople)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text("Time: \(booking.time)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()

                        Spacer()

                        Button(action: {
                            cancelBooking(booking)
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                }
                .padding(.horizontal)
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Booking List", displayMode: .automatic)
        }
    }

    func cancelBooking(_ booking: RestaurantDB) {
        booking.status = "failed"
        do {
            try modelContext.save()
        } catch {
            // Handle error
        }
    }
}

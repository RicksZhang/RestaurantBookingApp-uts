//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//

import SwiftUI
import SwiftData

struct ViewBookingListView: View {
    @Query private var bookings: [RestaurantDB]  //查找restaurantDB中的bookings数组
    @Environment(\.modelContext) private var modelContext  //注入 modelContext，操控context

    //
    var body: some View {
        NavigationView {
            List(bookings.filter { $0.status == "success" }, id: \.restaurantName) { booking in    // 为每个符合条件的booking创建视图，对booking过滤，只显示success的，id增加列表唯一性
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

    func cancelBooking(_ booking: RestaurantDB) {  //接受一个 RestaurantDB 实例，并将其状态更改为 "failed"，改变数据库
        booking.status = "failed"
        do {
            try modelContext.save()
        } catch {
            // Handle error
        }
    }
}

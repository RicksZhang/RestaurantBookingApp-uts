//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//


import Foundation
import SwiftData

@Model
class RestaurantDB {
    var restaurantName:String = ""
    var name:String = ""
    var phone:String = ""
    var numberofpeople:String = ""
    var status:String = ""
    var time:String = ""
    
    init(restaurantName: String, name: String, phone: String, numberofpeople: String, status: String, time: String) {
        self.restaurantName = restaurantName
        self.name = name
        self.phone = phone
        self.numberofpeople = numberofpeople
        self.status = status
        self.time = time
    }
  
}

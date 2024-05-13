//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//

import SwiftUI
import SwiftData

struct RestaurantView: View {
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var numberOfPeople = ""
    @State private var selectedDate = Date() 

    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @Environment(\.modelContext) var modelContext
    var item: Item
    
    var body: some View {
        ZStack {
            Color.init(red: 0.95, green: 0.9, blue: 0.8)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Form {
                    Section(header: Text("Reservation Information")
                        .font(.title)
                        .foregroundColor(.brown)) {
                            TextField("Name", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextField("Phone Number", text: $phoneNumber)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextField("Number of People", text: $numberOfPeople)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            DatePicker("Reservation Date", selection: $selectedDate, displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())
                        }
                    
                    Section(header: Text("Restaurant Food List")) {
                        List {
                            ForEach(0..<item.foodImagelist.count, id: \.self) { index in
                                NavigationLink(destination: ProductDetailsView(product: FoodItem(name: item.foodname[index], price: item.pricelist[index], image: item.foodImagelist[index], quantity: 1))) {
                                    HStack(alignment: .top) {
                                        Image(item.foodImagelist[index])
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100)
                                        
                                        VStack(alignment: .leading) {
                                            Text("\(item.foodname[index])")
                                                .font(.headline)
                                            Text("Price: $\(item.pricelist[index])")
                                                .font(.subheadline)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Seat Booking")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Submit") {
                        submitForm()
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                    clearFields()
                })
            }
        }
    }
    func submitForm() {
        if name.isEmpty || phoneNumber.isEmpty || numberOfPeople.isEmpty {
            alertTitle = "Missing Information"
            alertMessage = "Please fill in all fields."
            showingAlert = true
            return
        }


        if let _ = Int(phoneNumber) {
           
            if let _ = Int(numberOfPeople) {
               
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                dateFormatter.timeStyle = .short
                let currentDateAndTime = dateFormatter.string(from: Date())
                
   
                alertTitle = "Reservation Successful"
                alertMessage = "Thank you for your reservation!\n\nReservation Date: \(dateFormatter.string(from: selectedDate))\nCurrent Date and Time: \(currentDateAndTime)"
                saveData(Time: dateFormatter.string(from: selectedDate), Name: name, Phone: phoneNumber, Status: "success", numberofpeople: numberOfPeople)
                showingAlert = true
            } else {
                alertTitle = "Invalid Number of People"
                alertMessage = "Please enter a valid number for Number of People."
                showingAlert = true
            }
        } else {
            alertTitle = "Invalid Phone Number"
            alertMessage = "Please enter a valid phone number."
            showingAlert = true
        }
    }

    func clearFields() {
        name = ""
        phoneNumber = ""
        numberOfPeople = ""
        selectedDate = Date()
    }
    
    func saveData(Time: String, Name: String, Phone: String, Status: String,numberofpeople:String) {
        
        var newBooking = RestaurantDB(restaurantName: item.title, name: Name, phone: Phone, numberofpeople: numberofpeople, status: "success", time: Time)
    
        modelContext.insert(newBooking)
    }
    
    
}



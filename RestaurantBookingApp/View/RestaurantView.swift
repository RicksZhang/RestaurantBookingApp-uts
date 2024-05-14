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
    var item: Item    //传入的 Item 对象，包含餐厅的详细信息，如菜单和价格
    
    var body: some View {
        ZStack {
            Color.init(red: 0.95, green: 0.9, blue: 0.8)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Form {    //表单
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
                            DatePicker("Reservation Date", selection: $selectedDate, displayedComponents: .date)   //日期选择
                                .datePickerStyle(GraphicalDatePickerStyle())
                        }
                    
                    Section(header: Text("Restaurant Food List")) {
                        List {
                            ForEach(0..<item.foodImagelist.count, id: \.self) { index in    //生成从 0 到 item.foodImagelist.count（不包括 count）的整数序列
                                NavigationLink(destination: ProductDetailsView(product: FoodItem(name: item.foodname[index], price: item.pricelist[index], image: item.foodImagelist[index], quantity: 1))) {      //显示被点击的菜品
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
            .toolbar {   //submit按键
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        submitForm()
                    }) {
                        Text("Submit")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color(.systemBlue))
                            .clipShape(Capsule())
                            .shadow(color: Color(.systemBlue).opacity(0.3), radius: 5, x: 0, y: 5)
                    }
                }
            }
            .alert(isPresented: $showingAlert) {     //警告弹窗
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                    clearFields()
                })
            }
        }
    }
    func submitForm() {    // 验证表单，显示相应警告，保存数据
        if name.isEmpty || phoneNumber.isEmpty || numberOfPeople.isEmpty {
            alertTitle = "Missing Information"
            alertMessage = "Please fill in all fields."
            showingAlert = true
            return
        }


        if let _ = Int(phoneNumber) {
           
            if let _ = Int(numberOfPeople) {
               
                let dateFormatter = DateFormatter()     //日期格式化
                dateFormatter.dateStyle = .short
                dateFormatter.timeStyle = .short
                let currentDateAndTime = dateFormatter.string(from: Date())    //保存数据
                
   
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

    func clearFields() {     //清空重置表单，当提交表单后
        name = ""
        phoneNumber = ""
        numberOfPeople = ""
        selectedDate = Date()
    }
    
    func saveData(Time: String, Name: String, Phone: String, Status: String,numberofpeople:String) {
        
        var newBooking = RestaurantDB(restaurantName: item.title, name: Name, phone: Phone, numberofpeople: numberofpeople, status: "success", time: Time)     //将参数传入db
    
        modelContext.insert(newBooking)    //插入数据
    }
    
    
}



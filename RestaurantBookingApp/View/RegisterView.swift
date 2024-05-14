//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//


import SwiftUI

struct RegisterView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @Binding var isRegistering: Bool

    var body: some View {
        //背景色
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            //view 主体
            VStack(spacing: 20) {
                Spacer()

                Text("Register")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()

                TextField("Username", text: $username)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)

                TextField("Email", text: $email)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)
                    .keyboardType(.emailAddress)

                SecureField("Password", text: $password)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(10)
                    .padding(.horizontal, 24)

                Button(action: {    //注册function
                    register()
                }) {
                    Text("Register")
                        .foregroundColor(.white)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.mint]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(10)
                }
                .padding(.horizontal, 24)

                Spacer()
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func register() {
        guard !username.isEmpty else {
            showAlert(message: "Please enter username")
            return
        }

        guard !email.isEmpty else {
            showAlert(message: "Please enter email")
            return
        }

        guard !password.isEmpty else {
            showAlert(message: "Please enter password")
            return
        }

        UserDefaults.standard.set(username, forKey: "username")   //注册信息存储，login view调用
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")

        isRegistering = false
        print("Registering...")
    }

    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}

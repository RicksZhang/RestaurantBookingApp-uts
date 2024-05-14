//
//  ContentView.swift
//  RestaurantBookingApp
//
//  Created by MIngxuan Zhang on 12/5/2024.
//


import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isRegistering: Bool = false
    @State private var isLoggedIn: Bool = false

    var body: some View {
        NavigationView {
            //背景色
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.green, Color.mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    .edgesIgnoringSafeArea(.all)
                //view 主体
                VStack(spacing: 20) {
                    Spacer()

                    Text("GrubSeat")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.9, green: 0.6, blue: 0.3)) // 深绿色
                    .bold()
                    .shadow(color: .green, radius: 20, x: 0, y: 0)
                    .cornerRadius(10)
                    .overlay(
                    Text("GrubSeat")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 1.0, green: 0.6, blue: 0.2))
                    .bold()
                    .blur(radius: 1))
                    
                    TextField("Username", text: $username)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)

                    SecureField("Password", text: $password)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)

                    Button(action: {
                        login()     //调用函数进行登录认证
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(10)
                    }
                    .padding(.horizontal, 24)

                    Button(action: {
                        isRegistering = true     //弹出注册视图的 sheet
                    }) {
                        Text("Register")
                            .foregroundColor(.white)
                                    .font(.headline)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.indigo]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(10)
                    }
                    .padding(.horizontal, 24)

                    Spacer()
                }
                .padding()
                .sheet(isPresented: $isRegistering) {    //isRegistering = true  显示register view， $isregistering状态绑定，可是实时修改true or false
                    RegisterView(isRegistering: $isRegistering)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .navigationBarItems(trailing:      //导航链接，$isLoggedIn变为true，导航至ContentView
                    NavigationLink(
                        destination: ContentView(),
                        isActive: $isLoggedIn,
                        label: {
                        })
                )
            }
        }
    }

    func login() {    //从 UserDefaults 中读取之前保存的用户名和密码
        guard let savedUsername = UserDefaults.standard.string(forKey: "username") else {
            showAlert(message: "No user registered")
            return
        }

        guard let savedPassword = UserDefaults.standard.string(forKey: "password") else {
            showAlert(message: "No password registered")
            return
        }

        if username == savedUsername && password == savedPassword {      //用户密码判断，正确返回true向上传递到导航link
            isLoggedIn = true
        } else {
            showAlert(message: "Login failed. Please check your username and password.")
        }
    }

    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}

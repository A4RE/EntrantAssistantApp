//
//  AuthView.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 15.05.2024.
//

import SwiftUI

struct AuthView: View {
    
    @StateObject var authViewModel = AuthViewModel()
    
    @State private var username = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                loginTitle
                VStack(spacing: 20) {
                    TextField("Логин", text: $authViewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .textInputAutocapitalization(.never)
                    HStack {
                        if isPasswordVisible {
                            TextField("Пароль", text: $authViewModel.password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                        } else {
                            SecureField("Пароль", text: $authViewModel.password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                        }
                        
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                loginButton
                    .disabled(!authViewModel.isButtonEnabled)
                Spacer()
            }
            .padding(.horizontal, 16.adjustSize())
            .alert(isPresented: $authViewModel.showingAlert) {
                Alert(title: Text("Ошибка"), message: Text(authViewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $authViewModel.isAuthSuccessful) {
                TabBarView()
                    .navigationBarHidden(true)
            }
        }
    }
}

extension AuthView {
    
    var loginTitle: some View {
        Text("Авторизация")
            .font(.largeTitle)
            .fontWeight(.heavy)
    }
    
    var loginButton: some View {
        Button(action: {
            authViewModel.authenticate()
        }) {
            Text("Войти")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(authViewModel.isButtonEnabled ? Color.blue : Color.gray)
                .cornerRadius(20)
                .padding(.horizontal, 50)
        }
    }
}

#Preview {
    AuthView()
}

//
//  AuthViewModel.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 15.05.2024.
//

import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isButtonEnabled: Bool = false
    @Published var isAuthSuccessful = false
    @Published var showingAlert = false
    @Published var alertMessage: String = "Неверный логин или пароль"

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Publishers.CombineLatest($username, $password)
            .map { username, password in
                return !username.isEmpty && !password.isEmpty
            }
            .assign(to: \.isButtonEnabled, on: self)
            .store(in: &cancellables)
    }
    
    func authenticate() {
        guard let url = URL(string: "http://127.0.0.1:5000/login") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["login": username, "password": password]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print("Failed to serialize JSON")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> (Bool, String, Int?) in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
                if let result = authResponse.result.first, result.code == "Auth" {
                    return (true, result.status, result.user?.first?.id)
                } else if let result = authResponse.result.first {
                    return (false, result.status, nil)
                } else {
                    return (false, "Неверный логин или пароль", nil)
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    self.alertMessage = "Неверный логин или пароль"
                    self.showingAlert = true
                }
            }, receiveValue: { isSuccess, status, userId in
                self.isAuthSuccessful = isSuccess
                if isSuccess {
                    if let userId = userId {
                        UserDefaults.standard.setValue(userId, forKey: "UserID")
                    }
                } else {
                    self.alertMessage = status
                    self.showingAlert = true
                }
            })
            .store(in: &cancellables)
    }
}


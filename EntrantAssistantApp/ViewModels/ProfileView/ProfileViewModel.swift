//
//  ProfileViewModel.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 16.05.2024.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var userDetail: UserDetail?
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUserProfile(userId: String) {
        guard let url = URL(string: "http://127.0.0.1:5000/user/\(userId)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> Data in
                // Добавим отладку, чтобы вывести ответ сервера в виде строки
//                if let jsonString = String(data: data, encoding: .utf8) {
//                    print("JSON Response: \(jsonString)")
//                }
                return data
            }
            .decode(type: UserResult.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { userResult in
                self.userDetail = userResult.user.first
            })
            .store(in: &cancellables)
    }
}


//
//  DetailViewModel.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 15.05.2024.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    @Published var universityDetail: UniversityDetail?
    @Published var isLoading = false
    @Published var error: String?

    private var cancellable: AnyCancellable?

    func fetchUniversityDetail(id: Int) {
        isLoading = true
        error = nil

        guard let url = URL(string: "http://127.0.0.1:5000/unilist/\(id)") else {
            self.error = "Invalid URL"
            self.isLoading = false
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: UniversityDetailResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error.localizedDescription
                    self.isLoading = false
                }
            }, receiveValue: { response in
                self.universityDetail = response.uni.first
                self.isLoading = false
            })
    }
}

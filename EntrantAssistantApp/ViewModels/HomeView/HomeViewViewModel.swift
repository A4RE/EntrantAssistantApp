//
//  HomeViewViewModel.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 15.05.2024.
//

import Foundation
import Combine

class HomeViewViewModel: ObservableObject {
    @Published var universities: [University] = []
    @Published var searchText: String = ""
    
    private var originalUniversities: [University] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .sink { [weak self] searchText in
                self?.filterUniversities(with: searchText)
            }
            .store(in: &cancellables)
    }
    
    func fetchUniversities() {
        guard let url = URL(string: "http://127.0.0.1:5000/unilist") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let universityResponse = try JSONDecoder().decode(UniversityResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.universities = universityResponse.unis
                        self.originalUniversities = universityResponse.unis
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
    
    private func filterUniversities(with searchText: String) {
        if searchText.isEmpty {
            universities = originalUniversities
        } else {
            universities = originalUniversities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

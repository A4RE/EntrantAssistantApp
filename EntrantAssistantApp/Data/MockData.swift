//
//  MockData.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 30.04.2024.
//

import Foundation

struct UniInfoStruct: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let image: String
    let locationName: String
    let rating: Int
}

struct MockData {
    
    static func getAllUnis() -> [UniInfoStruct] {
        [
            .init(name: "Московский Государственный Университет имени М.В.Ломоносова", image: "example", locationName: "Москва", rating: 1),
            .init(name: "Московский Государственный Университет имени М.В.Ломоносова", image: "example", locationName: "Москва", rating: 2),
            .init(name: "Московский Государственный Университет имени М.В.Ломоносова", image: "example", locationName: "Москва", rating: 3),
            .init(name: "Московский Государственный Университет имени М.В.Ломоносова", image: "example", locationName: "Москва", rating: 4),
            .init(name: "Московский Государственный Университет имени М.В.Ломоносова", image: "example", locationName: "Москва", rating: 5),
            .init(name: "Московский Государственный Университет имени М.В.Ломоносова", image: "example", locationName: "Москва", rating: 6),
            .init(name: "Московский Государственный Университет имени М.В.Ломоносова", image: "example", locationName: "Москва", rating: 7),
            .init(name: "Московский Государственный Университет имени М.В.Ломоносова", image: "example", locationName: "Москва", rating: 8),
            .init(name: "Московский Государственный Университет имени М.В.Ломоносова", image: "example", locationName: "Москва", rating: 9),
            .init(name: "Московский Государственный Университет имени М.В.Ломоносова", image: "example", locationName: "Москва", rating: 10),
            .init(name: "Московский Государственный Университет имени М.В.Ломоносова", image: "example", locationName: "Москва", rating: 11),
            .init(name: "Московский Государственный Университет имени М.В.Ломоносова", image: "example", locationName: "Москва", rating: 12),
            .init(name: "Московский Государственный Университет имени М.В.Ломоносова", image: "example", locationName: "Москва", rating: 13),
            .init(name: "Московский Государственный Университет имени М.В.Ломоносова", image: "example", locationName: "Москва", rating: 14),
        ]
    }
}

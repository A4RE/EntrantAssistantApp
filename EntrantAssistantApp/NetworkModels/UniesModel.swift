//
//  UniesModel.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 15.05.2024.
//

import Foundation

struct UniversityResponse: Codable {
    let unis: [University]
}

struct University: Codable, Identifiable, Hashable {
    let id: Int
    let address: String?
    let bigPhoto: String
    let info: String?
    let name: String
    let photo: String
    let vuzopediaID: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case address = "addres"
        case bigPhoto = "big_photo"
        case info
        case name
        case photo
        case vuzopediaID = "vuzopedia_id"
    }
}

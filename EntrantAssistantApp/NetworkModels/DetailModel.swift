//
//  DetailModel.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 15.05.2024.
//

import Foundation

struct UniversityDetailResponse: Codable {
    let uni: [UniversityDetail]
}

struct UniversityDetail: Codable, Identifiable {
    let id: Int
    let address: String?
    let bigPhoto: String
    let info: String?
    let name: String
    let photo: String
    let programs: [Program]
    let vuzopediaID: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case address = "addres"
        case bigPhoto = "big_photo"
        case info
        case name
        case photo
        case programs = "programms"
        case vuzopediaID = "vuzopedia_id"
    }
}

struct Program: Codable, Identifiable {
    var id: String { code }
    let code: String
    let name: String
}

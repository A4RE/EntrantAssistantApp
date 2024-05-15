//
//  AuthResponse.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 16.05.2024.
//

import Foundation

struct AuthResponse: Codable {
    let result: [AuthResult]
}

struct AuthResult: Codable {
    let code: String
    let status: String
    let user: [User]?
}

struct User: Codable {
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
    }
}

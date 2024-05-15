//
//  UserResponse.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 16.05.2024.
//

import Foundation

struct UserResult: Codable {
    let user: [UserDetail]
}

struct UserDetail: Codable {
    let id: Int
    let birthdate: String
    let exams: [Exam]
    let login: String
    let mail: String?
    let name: String
    let password: String
    let phone: String?
    let programs: [Prog]
    let type: Int
    let unis: [Uni]

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case birthdate
        case exams
        case login
        case mail
        case name
        case password
        case phone
        case programs
        case type
        case unis
    }
}

struct Exam: Codable {
    let id: Int
    let name: String
    let points: Int

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name
        case points
    }
}

struct Prog: Codable {
    let code: String
    let name: String
}

struct Uni: Codable {
    let id: Int
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name
    }
}


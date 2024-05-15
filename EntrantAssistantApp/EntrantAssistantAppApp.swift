//
//  EntrantAssistantAppApp.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 30.04.2024.
//

import SwiftUI

@main
struct EntrantAssistantAppApp: App {
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.string(forKey: "UserID") != nil {
                TabBarView()
            } else {
                AuthView()
            }
        }
    }
}

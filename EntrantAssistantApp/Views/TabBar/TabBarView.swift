//
//  TabBarView.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 30.04.2024.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Список вузов", systemImage: "list.dash")
                }
            UserProfileView()
                .tabItem {
                    Label("Профиль", systemImage: "person.circle.fill")
                }
        }
    }
}

#Preview {
    TabBarView()
}

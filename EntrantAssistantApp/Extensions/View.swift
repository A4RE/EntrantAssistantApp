//
//  View.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 15.05.2024.
//

import SwiftUI

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

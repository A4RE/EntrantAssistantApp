//
//  Size.swift
//  EntrantAssistantApp
//
//  Created by Андрей Коваленко on 30.04.2024.
//

import UIKit

extension Double {
    
    func adjustSize() -> Double {
        
        let iPhone14ProScreenWidth = 393.0 / self
        return UIScreen.main.bounds.width / iPhone14ProScreenWidth
    }
    
    func roundTo() -> Double {
        
        return Double (self * 100).rounded() / 100
    }
}

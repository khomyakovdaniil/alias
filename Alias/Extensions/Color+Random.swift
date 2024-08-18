//
//  UIColor+Random.swift
//  Alias
//
//  Created by  Даниил Хомяков on 10.08.2024.
//

import Foundation
import SwiftUI

extension Color {
    static func random(randomOpacity: Bool = false) -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            opacity: randomOpacity ? .random(in: 0...1) : 1
        )
    }
}

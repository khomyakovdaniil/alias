//
//  UIApplication+EndEditing.swift
//  Alias
//
//  Created by  Даниил Хомяков on 18.08.2024.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

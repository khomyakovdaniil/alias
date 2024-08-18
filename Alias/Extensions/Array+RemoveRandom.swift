//
//  Array+RemoveRandom.swift
//  Alias
//
//  Created by  Даниил Хомяков on 17.08.2024.
//

import Foundation

extension Array {
    
    @discardableResult
    @inlinable public mutating func removeRandom() -> Element {
        self.remove(at: Int.random(in: 0...self.count-1))
    }
 
}

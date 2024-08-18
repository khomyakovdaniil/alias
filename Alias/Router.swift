//
//  Router.swift
//  Alias
//
//  Created by  Даниил Хомяков on 18.08.2024.
//

import Foundation

final class Router: ObservableObject {
    
    @Published var currentRoot: Screen = .mainMenu
        
    enum Screen : Equatable {
        case mainMenu
        case prepareRound
        case wordGuess
        case roundResult
        case gameResult
    }
}

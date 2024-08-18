//
//  GameManager.swift
//  Alias
//
//  Created by  Даниил Хомяков on 18.08.2024.
//

import Foundation
import SwiftUI

class GameManager: ObservableObject {
    
    init() {
        let team = Team()
        self.currentTeam = team
        self.teams = [team, Team()]
//        self.currentRoundResult = []
    }
    
    static var currentGame = GameManager()
   
    var teamNames = Constants.teamNames
    @Published var teams: [Team]
    @Published var currentTeam: Team
    @Published var currentRoundResult: [(String, Bool)] = []
    var currentRound = 1
    
    func addTeam() {
        teams.append(Team())
    }
    
    func removeTeam() {
        guard !teams.isEmpty else { return }
        teams.removeLast()
    }
    
    func nextTeam() {
        currentTeam.results.append(contentsOf: currentRoundResult)
        guard let index = teams.firstIndex(where: {$0.id == currentTeam.id}) else { return }
        if index+1 < teams.count {
            currentTeam = teams[index+1]
        } else {
            currentRound += 1
            currentTeam = teams.first!
        }
    }
    
    func changeNameForTeam(id: UUID, newName: String) {
        guard let team = teams.first(where: {$0.id == id} ) else { return }
        team.name = newName
    }
    
}


class Team {
    let id = UUID()
    var name = Constants.teamNames.randomElement()!
    var color = Color.random()
    var results: [(String, Bool)] = []
}

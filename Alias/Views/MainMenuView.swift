//
//  MainMenuView.swift
//  Alias
//
//  Created by  Даниил Хомяков on 10.08.2024.
//

import SwiftUI

struct MainMenuView: View {
    
    @EnvironmentObject 
    private var router: Router
    
    @StateObject
    var gameManager: GameManager = GameManager.currentGame
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Teams")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 3)
                    .padding()
                ScrollView {
                    LazyVStack() {
                        ForEach($gameManager.teams, id: \.id) { team in
                            TeamView(team: team.wrappedValue, teamName: team.name, gameResult: nil)
                                .padding(4)
                        }
                        Spacer()
                            .frame(height: 20)
                        AddAndRemoveTeamButtons()
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal, 40)
                StartGameButton() {
                    if gameManager.teams.count > 1 {
                        router.currentRoot = .prepareRound
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
}

struct TeamView: View {
    
    let team: Team
    @Binding var teamName: String
    let gameResult: Int?
    
    var body: some View {
        HStack {
            Circle()
                .fill(team.color)
                .frame(width: 50)
            TextField("Enter team name", text: $teamName)
                .font(.title3)
                .fontWeight(.bold)
            if let gameResult {
                Text("\(gameResult)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
            }
        }
        .padding(8)
        .background() {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.white)
                .stroke(.black, lineWidth: 5)
        }
    }
}

struct AddAndRemoveTeamButtons: View {
    
    var body: some View {
        HStack {
            Button(action: {
                UIApplication.shared.endEditing()
                GameManager.currentGame.addTeam()
            }, label: {
                Text("+")
                    .font(.title)
                    .frame(width: 34, height: 34)
                    .foregroundColor(.black)
                    .padding()
                    .background() {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.green)
                            .stroke(.black, lineWidth: 5)
                    }
            })
            Spacer()
                .frame(width: 34)
            Button(action: {
                UIApplication.shared.endEditing()
                GameManager.currentGame.removeTeam()
            }, label: {
                Text("-")
                    .font(.title)
                    .frame(width: 34, height: 34)
                    .foregroundColor(.black)
                    .padding()
                    .background() {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(.red)
                            .stroke(.black, lineWidth: 5)
                    }
            })
        }
    }
}

struct StartGameButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
           action()
        }, label: {
            Text("Start game")
                .font(.title)
                .foregroundColor(.black)
                .padding()
                .background() {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(.green)
                        .stroke(.black, lineWidth: 5)
                }
        })
    }
}

#Preview {
    MainMenuView()
}

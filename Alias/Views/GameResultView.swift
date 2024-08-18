//
//  GameResultView.swift
//  Alias
//
//  Created by  Даниил Хомяков on 18.08.2024.
//

import SwiftUI

struct GameResultView: View {
    
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
                Text("Game result")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 3)
                    .padding()
                Spacer()
                ScrollView {
                    LazyVStack {
                        ForEach($gameManager.teams, id: \.id) { team in
                            let successResult = team.wrappedValue.results.filter { $0.1 }
                            TeamView(team: team.wrappedValue, teamName: team.name, gameResult: successResult.count)
                                .padding(4)
                        }
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
                Button(action: {
                    GameManager.currentGame = GameManager()
                    router.currentRoot = .mainMenu
                }, label: {
                    Text("New game")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                        .background() {
                            RoundedRectangle(cornerRadius: 10.0)
                                .fill(.green)
                                .stroke(.black, lineWidth: 5)
                        }
                })
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    GameResultView()
}

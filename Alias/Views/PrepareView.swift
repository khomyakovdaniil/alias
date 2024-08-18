//
//  PrepareView.swift
//  Alias
//
//  Created by  Даниил Хомяков on 18.08.2024.
//

import SwiftUI

struct PrepareView: View {
    
    @EnvironmentObject private var router: Router
    
    @StateObject
    var gameManager: GameManager = GameManager.currentGame
    
    var body: some View {        
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Now it's time for")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 3)
                    .padding()
                TeamView(team: gameManager.currentTeam, teamName: $gameManager.currentTeam.name, gameResult: nil)
                    .padding(40)
                Text("to play the game")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 3)
                    .padding()
                Spacer()
                Button(action: {
                    router.currentRoot = .wordGuess
                }, label: {
                    Text("Ready")
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
    PrepareView()
}

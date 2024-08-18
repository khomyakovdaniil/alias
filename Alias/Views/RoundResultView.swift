//
//  RoundResultView.swift
//  Alias
//
//  Created by  Даниил Хомяков on 18.08.2024.
//

import SwiftUI

struct RoundResultView: View {
    
    @EnvironmentObject
    private var router: Router
    
    @StateObject
    var gameManager: GameManager = GameManager.currentGame
    
//    @State var testResult = [("One", true), ("Two", false)]
    
    // replace with gameManager.currentRoundResult
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text(gameManager.currentTeam.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 3)
                    .padding()
                Spacer()
                ScrollView(.vertical) {
                    LazyVStack(spacing: 10) {
                        ForEach(gameManager.currentRoundResult, id: \.0) { (word, result) in
                            HStack {
                                Text(word)
                                    .font(.title)
                                Spacer()
                                Image(systemName: result ? "checkmark" : "xmark")
                                    .font(.title2)
                                    .padding(8)
                                    .background() {
                                        Circle()
                                            .fill(result ? .green : .red)
                                    }
                                    .onTapGesture() {
                                        guard let index = gameManager.currentRoundResult.firstIndex(where: { $0.0 == word }) else {
                                            return
                                        }
                                        gameManager.currentRoundResult[index] = (word, !result)
                                    }
                                
                            }
                        }
                    }
                    .padding(20)
                }
                .background() {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(.white)
                        .stroke(.black, lineWidth: 5)
                }
                .padding(.horizontal, 40)
                HStack {
                    Text("Total:")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 3)
                        .padding()
                    Spacer()
                    let successResult = gameManager.currentTeam.results.filter { $0.1 }
                    let currentResult = gameManager.currentRoundResult.filter {
                        $0.1
                    }
                    Text("\(successResult.count) + \(currentResult.count)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 3)
                        .padding()
                }
                .padding(.horizontal, 40)
                Spacer()
                Button(action: {
                    gameManager.nextTeam()
                    if gameManager.currentRound < 5 {
                        router.currentRoot = .prepareRound
                    } else {
                        router.currentRoot = .gameResult
                    }
                }, label: {
                    Text("Next Round")
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
    RoundResultView()
}

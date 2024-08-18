//
//  WordGuessView.swift
//  Alias
//
//  Created by  Даниил Хомяков on 17.08.2024.
//

import SwiftUI
import AVFoundation

struct WordGuessView: View {
    
    @EnvironmentObject private var router: Router
    
    @StateObject
    var gameManager: GameManager = GameManager.currentGame
    
    @State var words = ["One", "Two", "Three", "Four"]
    @State var currentWord = "Test"
    
    @State var results: [(String, Bool)] = []
    @State var timesUp = false
    
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
                VStack(spacing: 40) {
                    TimerView(timesUp: $timesUp)
                    WordCardView(word: $currentWord)
                    YesOrNoButtonsView(yesAction: {
                        AudioServicesPlaySystemSound(1054)
                        results.append((currentWord, true))
                        nextWord()
                    },
                                       noAction: {
                        AudioServicesPlaySystemSound(1053)
                        results.append((currentWord, false))
                        nextWord()
                    }
                    )
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 40)
            }
            .onAppear() {
                words = Constants.wordList
                currentWord = words.removeRandom()
            }
        }
    }
    
    private func nextWord() {
        guard !words.isEmpty else {
            return
        }
        guard !timesUp else {
            GameManager.currentGame.currentRoundResult = results
            router.currentRoot = .roundResult
            return
        }
        let newWord = words.remove(at: Int.random(in: 0...words.count-1))
        currentWord = newWord
    }
}

struct TimerView: View {
    
    @Binding var timesUp: Bool
    
    @State private var duration = 0.0
    private let desiredDuration = Calendar.current.date(byAdding: .minute, value: 1, to: Date())!
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    static var duratioinFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropLeading
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                ProgressView(value: duration, total: 60.0)
                    .progressViewStyle(BarProgressStyle(color: .green, height: 25))
            }
        }
        .onReceive(timer) { _ in
            var delta = desiredDuration.timeIntervalSince(Date())
            if delta <= 0 {
                delta = 0
                AudioServicesPlaySystemSound(1014)
                timer.upstream.connect().cancel()
                timesUp = true
            }
            AudioServicesPlaySystemSound(1104)
            duration = delta
        }
    }
}

struct WordCardView: View {
    
    @Binding var word: String
    
    var body: some View {
        Text(word)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(width: UIScreen.main.bounds.size.width - 80, height: UIScreen.main.bounds.size.height / 2)
            .background() {
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(.white)
                    .stroke(.black, lineWidth: 5)
            }
            
    }
}

struct YesOrNoButtonsView: View {
    
    var yesAction: () -> Void
    var noAction: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.black)
                .background(
                    Circle()
                        .fill(.green)
                )
                .onTapGesture {
                    yesAction()
                }
            Spacer()
            Image(systemName: "xmark.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.black)
                .background(
                    Circle()
                        .fill(.red)
                )
                .onTapGesture {
                    noAction()
                }
        }
    }
    
}

struct BarProgressStyle: ProgressViewStyle {

    var color: Color = .purple
    var height: Double = 20.0
    var labelFontStyle: Font = .body

    func makeBody(configuration: Configuration) -> some View {

        let progress = configuration.fractionCompleted ?? 0.0

        GeometryReader { geometry in

            VStack(alignment: .leading) {

                configuration.label
                    .font(labelFontStyle)

                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color(uiColor: .systemGray5))
                    .stroke(.black, lineWidth: 2)
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(color)
                            .frame(width: geometry.size.width * progress, height: height - 4)
                            .overlay {
                                if let currentValueLabel = configuration.currentValueLabel {

                                    currentValueLabel
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                    }

            }

        }
    }
}



#Preview {
    WordGuessView()
}

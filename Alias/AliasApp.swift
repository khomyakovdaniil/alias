//
//  AliasApp.swift
//  Alias
//
//  Created by  Даниил Хомяков on 10.08.2024.
//

import SwiftUI
import Firebase

@main
struct AliasApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject private var router = Router()
    @State var remoteConfig: RemoteConfig!
    @State var privacyURL: URL?
    
    var body: some Scene {
        WindowGroup {
            Group {
                if privacyURL == nil {
                    switch router.currentRoot {
                    case .mainMenu:
                        MainMenuView()
                            .environmentObject(router)
                    case .prepareRound:
                        PrepareView()
                            .environmentObject(router)
                    case .wordGuess:
                        WordGuessView()
                            .environmentObject(router)
                    case .roundResult:
                        RoundResultView()
                            .environmentObject(router)
                    case .gameResult:
                        GameResultView()
                            .environmentObject(router)
                    }
                } else {
                    WebView(mode: .fullScreen, url: privacyURL!)
                }
            }
            .onAppear() {
                remoteConfig = RemoteConfig.remoteConfig()
                let settings = RemoteConfigSettings()
                settings.minimumFetchInterval = 0
                remoteConfig.configSettings = settings
                remoteConfig.fetch { (status, error) -> Void in
                    if status == .success {
                        self.remoteConfig.activate { changed, error in
                            let text = remoteConfig["privacy_url"].stringValue
                            if !text.contains("privacy") {
                                self.privacyURL = URL(string: text)
                            }
                        }
                    }
                }
                
            }
        }
    }
}

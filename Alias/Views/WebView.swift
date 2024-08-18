//
//  WebView.swift
//  Alias
//
//  Created by  Даниил Хомяков on 18.08.2024.
//

import SwiftUI
import WebKit

struct WebViewRepresentable: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let result = WKWebView()
        result.allowsBackForwardNavigationGestures = true
        return result
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

enum WebViewMode {
    case fullScreen
    case defaultMode
}

struct WebView: View {
    @Environment(\.presentationMode) var presentationMode
    let mode: WebViewMode
    let url: URL
    
    var body: some View {
        ZStack {
            WebViewRepresentable(url: url)
                .edgesIgnoringSafeArea(mode == .fullScreen ? .all : [])
            
            if mode == .defaultMode {
                VStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Close")
                            .padding()
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

#Preview {
    WebView(mode: .defaultMode, url: URL(string: "apple.com")!)
}

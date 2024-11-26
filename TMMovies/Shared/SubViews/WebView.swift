//
//  WebView.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/22/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}

#Preview {
    WebView(url: URL.homeDirectory)
}

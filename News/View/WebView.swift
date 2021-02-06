//
//  WebView.swift
//  News
//
//  Created by Nagaraj on 06/02/21.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    let wkWebView = WKWebView()
    func makeUIView(context: Context) -> some WKWebView {
        guard let url = URL(string: url) else {
            return wkWebView
        }
        
        let request = URLRequest(url: url)
        wkWebView.load(request)
        return wkWebView
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<WebView>) {
        
    }
}

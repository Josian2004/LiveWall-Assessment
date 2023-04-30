//
//  LoginView.swift
//  LiveWallAssessment
//
//  Created by Josian van Efferen on 29/04/2023.
//

import SwiftUI
import WebKit


struct WebView: UIViewRepresentable {
 
    var url: URL
    let authManager: AuthManager
    @Binding var showWebView: Bool
    @Binding var showLoginPage: Bool
 
    func makeUIView(context: Context) -> WKWebView {
        let wKWebView = WKWebView()
        wKWebView.navigationDelegate = context.coordinator
        return wKWebView
    }
 
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(self, authManager)
    }
    
    class WebViewCoordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        let authManager: AuthManager
        init(_ parent: WebView, _ authManager: AuthManager) {
            self.parent = parent
            self.authManager = authManager
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let urlStr = navigationAction.request.url?.absoluteString else { return }
            //let urlToMatch = "https://josian.nl/"
//            if let urlStr = navigationAction.request.url?.absoluteString, urlStr == urlToMatch {
//                parent.showWebView = false
//            }
            if (authManager.getCodeFromUrl(url: urlStr)) {
                parent.showWebView = false
                parent.showLoginPage = false
            }
            decisionHandler(.allow)
        }
        
    }
}


struct LoginView: View {
    @State private var showWebView = false
    @Binding var showLoginPage: Bool
    
    let authManager: AuthManager
    private let vm: LoginViewModel = LoginViewModel()
    
    
    var body: some View {
        Button {
            showWebView.toggle()
        } label: {
            Text("Login")
        }
        .sheet(isPresented: $showWebView) {
            WebView(url: URL(string: authManager.getAuthorizationUrl())!, authManager: authManager, showWebView: $showWebView, showLoginPage: $showLoginPage)
        }
            
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(authManager: AuthManager(), showLoginPage: @Binding true)
//    }
//}

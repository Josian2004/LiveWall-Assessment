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
    let authManager: LoginViewModel
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
        let authManager: LoginViewModel
        init(_ parent: WebView, _ authManager: LoginViewModel) {
            self.parent = parent
            self.authManager = authManager
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let urlStr = navigationAction.request.url?.absoluteString else { return }
            
            authManager.loginAttempt(url: urlStr, completion: {success in
                if (success) {
                    self.parent.showWebView = false
                    self.parent.showLoginPage = false
                }
            })
            decisionHandler(.allow)
        }
        
    }
}


struct LoginView: View {
    @State var showWebView: Bool
    @Binding var showLoginPage: Bool
    
    let authManager: AuthManager
    private let vm: LoginViewModel
    
    init(_showLoginPage: Binding<Bool>, _authManager: AuthManager) {
        self._showLoginPage = _showLoginPage
        self.authManager = _authManager
        self.vm = LoginViewModel(authManager: _authManager)
        _showWebView = State(initialValue: false)
    }
    
   
   
    
    
    var body: some View {
        Button {
            showWebView.toggle()
        } label: {
            Text("Login")
        }
        .sheet(isPresented: $showWebView) {
            WebView(url: authManager.getAuthorizationUrl(), authManager: vm, showWebView: $showWebView, showLoginPage: $showLoginPage)
        }
            
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(authManager: AuthManager(), showLoginPage: @Binding true)
//    }
//}

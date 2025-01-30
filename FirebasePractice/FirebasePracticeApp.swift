//
//  FirebasePracticeApp.swift
//  FirebasePractice
//
//  Created by Tanmay . on 29/01/25.
//

import FirebaseCore
import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

@main
struct FirebasePracticeApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)  -> Bool {
        // Initialize Firebase:
        FirebaseApp.configure()
        
        // Configure Google Sign In:
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: FirebaseApp.app()?.options.clientID ?? "")
        return true
    }
}

// Handle Google Sign-In URL redirects:
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
}

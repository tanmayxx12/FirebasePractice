//
//  FirebasePracticeApp.swift
//  FirebasePractice
//
//  Created by Tanmay . on 29/01/25.
//

import FirebaseCore
import SwiftUI

@main
struct FirebasePracticeApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

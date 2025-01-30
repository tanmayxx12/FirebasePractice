//
//  AuthService.swift
//  FirebasePractice
//
//  Created by Tanmay . on 30/01/25.
//

import FirebaseAuth
import Foundation
import GoogleSignIn
import GoogleSignInSwift


// Authentication Logic: Create a service class to handle Google Sign-In using Swift concurrency.

final class GoogleAuthService {
    static let shared = GoogleAuthService()
    private init() { }
    
    // MARK: Google Sign In
    func signInWithGoogle() async throws -> FirebaseAuth.User {
        // 1. Get the root view controller:
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = await windowScene.windows.first?.rootViewController else {
            throw AuthError.noRootViewController
        }
        
        // 2. Start Google Sign in flow
        let googleSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        
        // 3. Extract Google Credentials:
        guard let idToken = googleSignInResult.user.idToken?.tokenString else {
            throw AuthError.missingIDToken
        }
        let accessToken = googleSignInResult.user.accessToken.tokenString
        
        
        // 4. Create Firebase Credential:
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        // 5. Sign in to Firebase:
        let authResult = try await Auth.auth().signIn(with: credential)
        
        return authResult.user
    }
    
    // MARK: Sign Out
    func signOut() throws {
        try Auth.auth().signOut()
        GIDSignIn.sharedInstance.signOut() // Google sign out
    }
    
    
}

// AuthError enum:
/*
 enum AuthError: Error {
     case noCurrentUser, emailNotVerified, noRootViewController, missingIDToken
 }
 */

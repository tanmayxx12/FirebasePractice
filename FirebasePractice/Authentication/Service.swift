//
//  AuthenticationService.swift
//  FirebasePractice
//
//  Created by Tanmay . on 29/01/25.
//

import FirebaseAuth
import Foundation


actor AuthService {
    static let shared = AuthService() // Singleton
    
    // MARK: Sign Up:
    func signUp(email: String, password: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        try await result.user.sendEmailVerification() // Send verification email
    }
    
    // MARK: Sign In:
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
        guard let user = Auth.auth().currentUser else {
            throw AuthError.noCurrentUser
        }
        if !user.isEmailVerified {
            throw AuthError.emailNotVerified
        }
        
    }
    
    // MARK: Update Email: (Requires recent auth)
    func updateEmail(newEmail: String, currentPassword: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.noCurrentUser
        }
        
        // Reauthenticate with current credentials:
        let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: currentPassword)
        try await user.reauthenticate(with: credential)
        try await user.sendEmailVerification(beforeUpdatingEmail: newEmail)
    }
    
    // MARK: Update Password: (Requires recent auth)
    func updatePassword(newPassword: String, currentPassword: String) async throws {
        guard let user = Auth.auth().currentUser else {
            throw AuthError.noCurrentUser
        }
        
        // Reauthenticate with current credentials:
        let credential = EmailAuthProvider.credential(withEmail: user.email ?? "" , password: currentPassword)
        try await user.reauthenticate(with: credential)
        try await user.updatePassword(to: newPassword)
    }
    
    // MARK: Reset Password
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}

enum AuthError: Error {
    case noCurrentUser, emailNotVerified, noRootViewController, missingIDToken
}

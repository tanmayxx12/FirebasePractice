//
//  AuthViewModel.swift
//  FirebasePractice
//
//  Created by Tanmay . on 29/01/25.
//

import SwiftUI

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var currentPassword: String = ""  // For email/password updates
    @Published var errorMessage: String?
    
    private let authService = AuthService.shared
    
    // MARK: Sign Up
    func signUp() async {
        do {
            try await authService.signUp(email: email, password: password)
            errorMessage = "Verification email sent. Confirm to log in."
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    // MARK: Sign In:
    func signIn() async {
        do {
            try await authService.signIn(email: email, password: password)
            errorMessage = nil // Successful log in
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    // MARK: Update Email
    func updateEmail(newEmail: String) async {
        do {
            try await authService.updateEmail(newEmail: newEmail, currentPassword: currentPassword)
            errorMessage = "Email Updated"
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    // MARK: Reset Password
    func resetPassword() async {
        do {
            try await authService.resetPassword(email: email)
            errorMessage = "Password reset email sent."
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
}

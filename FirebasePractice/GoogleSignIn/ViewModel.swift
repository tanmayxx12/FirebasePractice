//
//  ViewModel.swift
//  FirebasePractice
//
//  Created by Tanmay . on 30/01/25.
//

import FirebaseAuth
import Foundation


// Creating a view model for state management

@MainActor
final class GoogleAuthViewModel: ObservableObject {
    @Published var user: FirebaseAuth.User?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    private let googleAuthService = GoogleAuthService.shared
    
    // MARK: Google Sign In
    func signInWithGoogle() async {
        isLoading = true
        
        do {
            let user = try await googleAuthService.signInWithGoogle()
            self.user = user
            errorMessage = nil
        } catch {
            print("There was an error: \(error.localizedDescription)")
        }
        
        isLoading = false
    }
    
    // MARK: Google Sign Out
    func signOut()  {
        do {
            try googleAuthService.signOut()
            user = nil
        } catch {
            print("There was an error: \(error.localizedDescription)")
        }
    }
    
    // MARK: Error Handling
    /*
     private func handleError(_ error: Error) {
         switch error {
         case AuthError.noRootViewController:
             errorMessage = "Failed to start Google Sign in. Please restart the app."
         case AuthError.missingIDToken:
             errorMessage = "Google Sign in failed. Please try again."
         case let error as NSError where error.domain == GIDSignInErrorDomain:
               errorMessage = "Google Sign-In error: \(error.localizedDescription)"
         }
         
         
     }
     */

}


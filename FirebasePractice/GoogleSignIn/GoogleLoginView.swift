//
//  GoogleLoginView.swift
//  FirebasePractice
//
//  Created by Tanmay . on 30/01/25.
//

import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

struct GoogleLoginView: View {
    @StateObject private var googleViewModel = GoogleAuthViewModel()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if googleViewModel.isLoading {
                    ProgressView()
                } else {
                    // Google Sign In Button:
                    GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(
                        scheme: .dark,
                        style: .wide,
                        state: .normal
                    )) {
                        Task {
                            await googleViewModel.signInWithGoogle()
                        }
                    }
                    .frame(width: 280, height: 45)
                }
                
                if let errorMessage = googleViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                }
                
                if googleViewModel.user != nil {
                    Text("Welcome, \(googleViewModel.user?.displayName ?? "User")!")
                    Button("Sign Out") {
                        googleViewModel.signOut()
                    }
                }
                
            }
            .padding()
            
        }
    }
}

#Preview {
    GoogleLoginView()
}

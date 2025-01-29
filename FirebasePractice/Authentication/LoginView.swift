//
//  LoginView.swift
//  FirebasePractice
//
//  Created by Tanmay . on 29/01/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Email...", text: $viewModel.email)
                    .font(.headline)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.black.opacity(0.2))
                    .padding(.horizontal, 8)
                    .cornerRadius(20)
                
                SecureField("Password...", text: $viewModel.password)
                    .font(.headline)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.black.opacity(0.2))
                    .padding(.horizontal, 8)
                    .cornerRadius(20)
                
                HStack(spacing: 20) {
                    Button("Sign Up") {
                        Task {
                            await viewModel.signUp()
                        }
                    }
                    .font(.headline)
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    
                    Button("Sign In") {
                        Task {
                            await viewModel.signIn()
                        }
                    }
                    .font(.headline)
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    
                    Button("Reset Password") {
                        Task {
                            await viewModel.resetPassword()
                        }
                    }
                    .font(.headline)
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    
                }
                .padding(.top)
                
            }
        }
    }
}

#Preview {
    LoginView()
}

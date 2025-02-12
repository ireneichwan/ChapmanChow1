//
//  LoginView.swift
//  ChapmanChow
//
//  Created by Irene Ichwan on 2/12/25.
//
import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String?
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Text("ChapmanChow")
                .font(.largeTitle)
                .bold()
                .padding()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Button("Login") {
                authViewModel.signIn(email: email, password: password) { success, error in
                    if !success {
                        errorMessage = error
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()

        }
        .padding()
    }
}


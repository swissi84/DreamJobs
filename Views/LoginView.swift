//
//  LoginView.swift
//  TraumJobs
//
//  Created by Eggenschwiler Andre on 20.09.24.
//
import SwiftUI

struct LoginView: View {

    @AppStorage("username")
    private var username: String = ""

    @AppStorage("isUserLoggedIn")
    private var isUserLoggedIn = false

    var body: some View {
        VStack {
            Image("header")
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
            if username.isEmpty {
                Text("Please Enter your Name to Login")
            } else {
                Text("Welcome \(username) to DreamJobs")
            }
            TextField("username", text: $username)
                .textFieldStyle(.roundedBorder)
                .padding()
                
            Button("Login") {
                
                isUserLoggedIn = true
            }
            .disabled(username.isEmpty)
        }
        .padding()
        .bold()
        .monospaced()
    }
}

#Preview {
    LoginView()
}

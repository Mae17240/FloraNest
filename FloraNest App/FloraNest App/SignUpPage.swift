//
//  SignUpPage.swift
//  FloraNest App
//
//  Created by Joshua Mae on 23/04/2025.
//

import Foundation
import SwiftUI

struct SignUpPage: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        ZStack {
            Image("MainHome")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Create Account")
                    .font(.largeTitle)
                
                TextField("Full Name", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .frame(maxWidth: 250)
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal)
                    .frame(maxWidth: 250)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .frame(maxWidth: 250)
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .frame(maxWidth: 250)
                
                
                Button("Sign Up") {
                    
                }
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .foregroundColor(.black)
                .padding(.top, 50)
                .frame(maxWidth: 150)
            }
            .padding()
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        SignUpPage()
            .previewDevice("iPhone 15")
    }
}

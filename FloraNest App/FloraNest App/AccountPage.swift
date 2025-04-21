//
//  AccountPage.swift
//  FloraNest App
//
//  Created by Joshua Mae on 21/04/2025.
//

import SwiftUI
import AuthenticationServices



struct AccountPage: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("MainHome")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {

                    Text("Sign Into your Account")
                        .font(Font.custom("Fraunces", size: 25))
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                        .padding(.top, 300)
                        .padding(.bottom, 15)

                    SignInWithAppleButton(
                        .signIn,
                        onRequest: { request in
                            request.requestedScopes = [.fullName, .email]
                        },
                        onCompletion: { result in
                            switch result {
                            case .success(let authorization):
                                print("Authorization successful: \(authorization)")
                            case .failure(let error):
                                print("Authorization failed: \(error.localizedDescription)")
                            }
                        }
                    )
                    .signInWithAppleButtonStyle(.white)
                    .frame(height: 50)
                    .frame(width: 150)
                    .cornerRadius(10)
                    .padding(5)

                    Spacer()
                }
            }
        }
    }
}


struct ActPage_Previews: PreviewProvider {
    static var previews: some View {
        AccountPage()
            .previewDevice("iPhone 15")
    }
}


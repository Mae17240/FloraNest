//
//  SignInOrUp.swift
//  FloraNest App
//
//  Created by Joshua Mae on 24/04/2025.
//

import Foundation
import SwiftUI

struct SignInOrUp: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("MainHome")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        VStack() {
                            Text("Sign Into your account.")
                                .font(Font.custom("Fraunces", size: 30))
                                .padding(.top, 70)
                                .foregroundColor(.black)
                            
                            Text("Or Sign up for a new one.")
                                .font(Font.custom("Poppins", size: 15))
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                    }
                    Spacer()
                    
                    Rectangle() // + image or info about login accountss.
                        .fill(Color.white.opacity(0.5))
                        .frame(width: 350, height: 350)
                    
                        
                    
                    Spacer()
                    // bottom bar nav buttons.
                    HStack(spacing: 100) {
                        NavigationLink(destination: SignIntoAcc()) {
                            Text("Sign in")
                                .font(Font.custom("Poppins-regular", size: 15))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .frame(width: 100)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(60)
                        
                        NavigationLink(destination: SignUpPage()) {
                            Text("Sign Up")
                                .font(Font.custom("Poppins-regular", size: 15))
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .frame(width: 100)
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(60)
                    }
                    .padding(.bottom, 50)
                }
            }
        }
    }
}

struct SignInOrUp_Previews: PreviewProvider {
    static var previews: some View {
        SignInOrUp()
            .previewDevice("iPhone 15")
    }
}

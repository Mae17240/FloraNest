//
//  SignUpSucc.swift
//  FloraNest App
//
//  Created by Joshua Mae on 24/04/2025.
//

import Foundation
import SwiftUI


import SwiftUI

struct SignUpSucc: View {
    var body: some View {
        NavigationView {
            
            ZStack {
                Image("MainHome")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        VStack  {
                            Text("Sign Up Successful!")
                                .font(Font.custom("Fraunces", size: 30))
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                    }
                }
            }
        }
    }
}

struct SignUpSucc_Previews: PreviewProvider {
    static var previews: some View {
        SignUpSucc()
            .previewDevice("iPhone 15")
    }
}




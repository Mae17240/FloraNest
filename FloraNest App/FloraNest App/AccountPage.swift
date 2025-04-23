//
//  AccountPage.swift
//  FloraNest App
//
//  Created by Joshua Mae on 21/04/2025.
//


import SwiftUI
import AuthenticationServices


struct AccountPage: View {

        let images = ["AloeVeraImg", "PothosIMG"]
        @State private var currentIndex = 0
        
        // scroll timer
        let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
        
        var body: some View {
            NavigationView {
                ZStack {
                    Image("MainHome")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Text("Your Account.")
                            .font(Font.custom("Fraunces", size: 30))
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                            .padding(.top, 50)
                            .padding(.bottom, 50)
                        
                        
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white.opacity(1))
                            .frame(height: 300)
                            .frame(width: 300)
                            .overlay(
                                TabView(selection: $currentIndex) {
                                    ForEach(0..<images.count, id: \.self) { index in
                                        Image(images[index])
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .tag(index)
                                    }
                                }
                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                    .frame(height: 300)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            )
                            .padding(.horizontal)
                            .onReceive(timer) { _ in
                                withAnimation {
                                    currentIndex = (currentIndex + 1) % images.count
                                }
                            }
                        
                        
                        
                        Spacer()
                        //homepage button
                        RoundedRectangle(cornerRadius: 60)
                            .fill(Color.black.opacity(0))
                            .frame(height: 60)
                            .frame(width: 200)
                            .padding(.top, 200)
                            .overlay(
                                HStack(spacing: 200){
                                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)){
                                        Image("HomeBtn")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 57, height: 57)
                                    }
                                }
                            )
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


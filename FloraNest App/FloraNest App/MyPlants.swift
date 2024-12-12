//
//  MyPlants.swift
//  FloraNest App
//
//  Created by Joshua Mae on 12/12/2024.
//
import SwiftUI

struct MyPlants: View {
    var body: some View {
        ZStack {
            //Background Image
            Image("FNbackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
//my plants spaced text
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: -15) {
                        Text("My")
                            .font(Font.custom("Headline", size: 60))
                            .foregroundColor(.white)
                            .fontWeight(.light)
                            
                        Text("Plants.")
                            .font(Font.custom("Poppins-regular", size: 40))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    .padding(.leading, 75)
                    Spacer()
                }
                Spacer()
                
                //bottom menu-bar to hold my Button(images)
                RoundedRectangle(cornerRadius: 60)
                    .fill(Color.black.opacity(0))
                    .frame(height: 60)
                    .frame(width: 350)
                    .overlay(
                        HStack(spacing: 200){
                            Image("HomeBtn")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                            Image("PlantBtn")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                    )
                
                
            }
        }
    }
}

struct MyPlants_Previews: PreviewProvider {
    static var previews: some View {
        MyPlants()
            .previewDevice("iPhone 15")
    }
}


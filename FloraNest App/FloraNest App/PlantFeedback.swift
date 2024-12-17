//
//  PlantFeedback.swift
//  FloraNest App
//
//  Created by Joshua Mae on 12/12/2024.
//
import SwiftUI

struct PlantFeedback: View {
    var body: some View {
        NavigationView {
            
            ZStack {
                //Background Image
                Image("MyPlants")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                //my plants spaced text
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: -5)  { //(header vertical spacing!)
                            Text("Plant Info.")
                                .font(Font.custom("Fraunces", size: 40))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                            
                            Text("About This Plant.")
                                .font(Font.custom("Poppins-regular", size: 20))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                        }
                        .padding(.leading, 130)
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

struct PlantFeedback_Previews: PreviewProvider {
    static var previews: some View {
        PlantFeedback()
            .previewDevice("iPhone 15")
    }
}



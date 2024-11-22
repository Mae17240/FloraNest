//
//  ContentView.swift
//  FloraNest App
//
//  Created by Joshua Mae on 08/11/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("FNbackground")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 500, height: 1000)
                    .edgesIgnoringSafeArea(.all)
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

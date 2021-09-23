//
//  ContentView.swift
//  Animations
//
//  Created by Eros Maurilio on 22/09/21.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmout: CGFloat = 1
    
    var body: some View {
        Button("Tap Me") {
            // action
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .scaleEffect(animationAmout)
        .blur(radius: (animationAmout - 1) * 3)
        .animation(.default)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

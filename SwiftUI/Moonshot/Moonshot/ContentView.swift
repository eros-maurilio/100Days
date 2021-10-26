//
//  ContentView.swift
//  Moonshot
//
//  Created by Eros Maurilio on 25/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            GeometryReader { geo in
                Image("example")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

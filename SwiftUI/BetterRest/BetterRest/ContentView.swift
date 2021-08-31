//
//  ContentView.swift
//  BetterRest
//
//  Created by Eros Maurilio on 30/08/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmout = 8.0
    var body: some View {
        Stepper(value: $sleepAmout, in: 4...12, step: 0.25) {
            Text("\(sleepAmout, specifier:  "%g") hours")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

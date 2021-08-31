//
//  ContentView.swift
//  BetterRest
//
//  Created by Eros Maurilio on 30/08/21.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date()
    
    var body: some View {
        let now = Date()
        let tomorrow = Date().addingTimeInterval(86400)
        let range = now...tomorrow
        
        
        
        DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
                .labelsHidden()
                
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
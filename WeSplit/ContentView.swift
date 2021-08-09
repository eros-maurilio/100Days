//
//  ContentView.swift
//  WeSplit
//
//  Created by Eros Maurilio on 09/08/21.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    @State private var name = ""
    private var students = ["Eros", "Ana", "Erick", "Djeni"]
    @State private var selectedStudent = "Eros"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                Text("Hello, world!")
                    .padding()
                }
                
                Section {
                    Button("Tap Count \(tapCount)") {
                        self.tapCount += 1
                    }
                }
                
                Section {
                    TextField("Enter you name:", text: $name)
                    Text("Your name is \(name)")
                    
                }
                
                Section {
                    ForEach(0..<students.count) {
                        Text(self.students[$0])
                        
                    }
                }
                
                Section {
                    Picker("Select your student", selection: $selectedStudent) {
                        ForEach(0..<students.count) {
                            Text(self.students[$0])
                        }
                    }
                }
            }
            .navigationBarTitle(Text("SwiftUI"), displayMode: .automatic)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Eros Maurilio on 28/09/21.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicationTable = 1
    private var options = ["5", "10", "20", "All"]
    @State private var positionPicker = "5"
    @State private var convertedPicker = 5
    
    var body: some View {
        VStack {
            Spacer()

            Text("Table Game")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(Color("DeepBlue"))
            
            VStack(alignment: .leading) {
                Text("How far do you want to answer?")
                    .padding(.top, 20)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                
                HStack {
                    Text("Up to")
                        .bold()
                        .padding(.leading, 10)
                        .padding(.vertical, 10)
                        .font(.body)
                    Text("\(multiplicationTable)")
                        .font(.system(size: 17, weight: .black, design: .rounded))
                    
                    Stepper("", value: $multiplicationTable, in: 1...12)
                        .colorMultiply(Color("Orange"))
                        .padding(.trailing, 3)
                }
                .background(Color.black.opacity(0.05)
                                .cornerRadius(10))
                
                Text("Choose how many questions you want to answer")
                    .padding(.top, 20)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                
                VStack {
                    Picker("", selection: $positionPicker) {
                        ForEach(options, id: \.self) {
                            Text($0)
                        }
                    }
                    .colorMultiply(Color("Orange"))
                    .pickerStyle(.segmented)
                    .onChange(of: positionPicker) { newValue in
                        convertedPicker = conversion(num: newValue)
                    }
                }
                .padding(.bottom, 150)
                
                NavigationLink {
                    GameView(multiplicationTable: $multiplicationTable, max: convertedPicker)
                    
                } label: {
                    HStack {
                        Spacer()
                        Text("Play")
                            .bold()
                        Spacer()
                    }
                    .padding(.vertical, 6)
                    .background(Color("Orange"))
                    .cornerRadius(5)
                    .padding(.horizontal, 10)
                }

            }
            .padding()

        }
        .foregroundColor(Color("DeepBlue"))
    }
    
    func conversion(num: String) -> Int { Int(num)! }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

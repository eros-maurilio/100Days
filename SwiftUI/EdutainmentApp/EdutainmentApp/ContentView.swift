//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Eros Maurilio on 28/09/21.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicationTable = 1
    @State private var options = ["5", "10"]
    @State private var positionPicker = "5"
    @State private var convertedPicker = "5"
    
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
                        .onChange(of: multiplicationTable, perform: { newValue in
                            withAnimation(.linear(duration: 0.3)) {
                                
                                if newValue >= 2 && !options.contains("20"){
                                    options.append("20")
                                } else {
                                    if newValue < 2 && options.contains("20") { options.removeLast()}
                                    
                                }
                                
                                if newValue >= 3 && !options.contains("All") {
                                    options.append("All")
                                    
                                } else {
                                    if newValue < 3 && options.contains("All") { options.removeLast()}
                                    
                                }
                                
                            }
                        })
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
                                .font(.title3)
                                .animation(.easeInOut)
                        }
                    }
                    .colorMultiply(Color("Orange"))
                    .pickerStyle(.segmented)
                    .onChange(of: positionPicker) { newValue in
                        convertedPicker = String(newValue)
                    }
                }
                .padding(.bottom, 150)
                
                NavigationLink {
                    GameView(multiplicationTable: $multiplicationTable, max: convertedPicker)
                    
                } label: {
                    HStack {
                        Spacer()
                        Text("Play")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    .padding(.vertical, 10)
                    .background(Color("Orange"))
                    .cornerRadius(5)
                    .padding(.horizontal, 10)
                }
                
            }
            .padding()
            
        }
        .foregroundColor(Color("DeepBlue"))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  Guess the flag
//
//  Created by Eros Maurilio on 13/08/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAwnser = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(.systemGray), .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                        
            VStack(spacing: 30) {

                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .padding(.top, 60)
                    
                    Text(countries[correctAwnser])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }

                
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }, label: {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
                            .shadow(color: .black.opacity(0.2), radius: 2)
                        
                            
                            
                    })
                    
                }
                Spacer()
            }
            .alert(isPresented: $showingScore, content: {
                Alert(title: Text(scoreTitle), message: Text("Your score is ???"), dismissButton: .default(Text("Continue")){
                    self.askQuestion()
                })
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAwnser {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAwnser = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

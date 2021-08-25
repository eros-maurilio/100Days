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
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(.systemGray), .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                        
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
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
                        FlagImage(image: countries[number])
                        
                    })
                }
                Text("Score: \(score)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.top, 20)
                
                Spacer()
            }
            .foregroundColor(.white)
            .alert(isPresented: $showingScore, content: {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
                    self.askQuestion()
                })
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAwnser {
            scoreTitle = "Correct"
            score += 1
        } else {
            let wrongFlag = countries[number]
            scoreTitle = "Wrong! That’s the flag of \(wrongFlag)"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAwnser = Int.random(in: 0...2)
    }
}

struct FlagImage: View {
    var image: String
    
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
            .shadow(color: .black.opacity(0.2), radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

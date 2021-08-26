//
//  ContentView.swift
//  Challenge2
//
//  Created by Eros Maurilio on 26/08/21.
//

import SwiftUI

struct ContentView: View {
    @State var moves = ["🪨", "📄", "✂️"]
    @State var appChoice = ["🪨", "📄", "✂️"].shuffled()
    @State var score = 0
    @State var shouldWin = Bool.random()
    @State var isShowingEndGameAlert = false
    @State var endGameTitle = ""
    @State var questionNum = 0
    
    var body: some View {
        ZStack {
            Color(.systemGray5).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(shouldWin ? "Win" : "Lose")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .opacity(0.3)
                    .padding()
                
                Spacer()
        
                Text(appChoice[0])
                    .font(.system(size: 180))
        
                Spacer()
                
                HStack {
                    ForEach(0..<moves.count) { number in
                        Button(action: {
                            self.chosenMove(number)
                            self.rockPaperScissor()
                            questionNum += 1

                        }, label: {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(maxHeight: 130)
                                .foregroundColor(Color(.systemGray6))
                                .overlay(Text(moves[number])
                                            .font(.system(size: 80))
                                            .padding())
                        })
                    }
                }
                .padding()
            }
        }
        .alert(isPresented: $isShowingEndGameAlert, content: {
            Alert(title: Text(endGameTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")){
                self.rockPaperScissor()
                score = 0
            })
        })
    }
    
    func rockPaperScissor() {
        appChoice.shuffle()
        shouldWin = Bool.random()
        
        if questionNum == 10 {
            isShowingEndGameAlert.toggle()
        }
    }
    
    func chosenMove(_ number: Int) {
        if shouldWin {
            if moves[number] == "🪨" && appChoice[0] == "✂️" {
                score += 1
            }
            else if moves[number] == "📄" && appChoice[0] == "🪨"{
                score += 1
            }
            else if moves[number] == "✂️" && appChoice[0] == "📄" {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if moves[number] == "🪨" && appChoice[0] != "✂️" {
                score += 1
            }
            else if moves[number] == "📄" && appChoice[0] != "🪨"{
                score += 1
            }
            else if moves[number] == "✂️" && appChoice[0] != "📄" {
                score += 1
            } else {
                score -= 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

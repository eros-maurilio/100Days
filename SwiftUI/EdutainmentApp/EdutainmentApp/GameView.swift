//
//  GameView.swift
//  EdutainmentApp
//
//  Created by Eros Maurilio on 13/10/21.
//

import SwiftUI

struct GameView: View {
    @Binding var multiplicationTable: Int
    @State var tableContent = [Int]()
    @State var tableSet = [Int]()
    @State var rIndex = 0
    @State var multiplying = 0
    @State var multiplier = 0
    @State var anwser: [String] = []
    @State var counter = 0
    @State var result = 0
    @State var score = 0
    @State var isCorrect = true
    @State var max: String
    @State var converted = 0
    @State var questionNum = 0
    @State var isShowing = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Spacer()
            Text("What is \(multiplying) x \(multiplier)?")
                .onAppear { gameSetup() }

            Verification(code: $anwser)
                .animation(.spring())
            
            Button {
                result = arrayTransform(list: anwser)
                
                if result == multiplying * multiplier {
                    score += 1
                } else {
                    isCorrect = false
                }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { isCorrect = true }

                questionNum += 1
                questions(count: counter)
                anwser.removeAll()

            } label: {
                HStack(alignment: .bottom) {
                    Spacer()
                    Text("OK")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.vertical, 10)
                .background(Color("DeepBlue").cornerRadius(10))
                .padding()
                .padding(.horizontal, 20)
                .opacity(anwser.isEmpty ? 0.2 : 1)

            }
            .disabled(anwser.isEmpty)

        }.overlay(Color.red.opacity(isCorrect ? 0 : 0.3))
            .alert(isPresented: $isShowing) {
                Alert(
                    title: Text("Score"),
                    message: Text("Your score was \(score)"),
                    primaryButton: .default(Text("Exit"), action: {
                    self.mode.wrappedValue.dismiss()

                    }), secondaryButton: .default(Text("Play Again"), action: {
                        reset()
                    }))
            }
            .onChange(of: questionNum) { newValue in
                if questionNum == converted { isShowing = true }
            }
    }
    
    func arrayTransform(list: [String]) -> Int{
        var num = ""
        
        for i in list {
            num += i
        }
        
        return Int(num) ?? 0
    }
    
    func questions(count: Int) {
        
        if questionNum != converted {
        multiplying = tableSet[counter]
        multiplier = tableSet[counter + 1]
        
        counter += 2
        }
    }
    
    func getSet(max: Int) {
        var count = tableContent.count
        
        for _ in 1...max {
            count = tableContent.count
            
            rIndex = randomIndex(of: count)
            
            tableSet.append(tableContent[rIndex])
            tableSet.append(tableContent[rIndex + 1])
            
            tableContent.remove(at: rIndex)
            tableContent.remove(at: rIndex)

            if rIndex != 0 { count -= 2 }
            if count == 1 { count -= 1 }

        }
    }
    
    func randomIndex(of: Int) -> Int {
        var randomIndex: Int
        let count = of - 1
        
        repeat {
            randomIndex = Int.random(in: 0...count)
            if randomIndex == 0 {
                break
            }
        } while randomIndex % 2 != 0

        return randomIndex
    }
    
    func getTable(upTo: Int) {
        for mult in 1...upTo {
            for num in 1...10 {
                tableContent.append(mult)
                tableContent.append(num)
            }
        }
    }
    
    func conversion(num: String) -> Int {
        var converted = 0
        
        if Int(num) == nil {
            converted = tableContent.count / 2
        } else {
            converted = Int(num)!
        }

        return converted
    }
    
    func gameSetup() {
        getTable(upTo: multiplicationTable)
        converted = conversion(num: max)
        getSet(max: converted)
        questions(count: counter)
        
    }
    
    func reset() {
        score = 0
        rIndex = 0
        multiplier = 0
        multiplying = 0
        counter = 0
        result = 0
        converted = 0
        questionNum = 0
        isShowing = false
        tableSet = [Int]()
        tableContent = [Int]()
        
        gameSetup()
        
    }
}

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
    var max: Int
    
    //@State var
    
    var body: some View {
        VStack {
            Spacer()
            Text("What is \(multiplying) x \(multiplier)?")
                .onAppear {
                    getTable(upTo: multiplicationTable)
                    getSet(max: max)
                    questions(count: counter)
                }
            
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

            }

        }.overlay(Color.red.opacity(isCorrect ? 0 : 0.3))

    }
    
    func arrayTransform(list: [String]) -> Int{
        var num = ""
        
        for i in list {
            num += i
        }
        
        return Int(num)!
    }
    
    func questions(count: Int) {
        multiplying = tableSet[counter]
        multiplier = tableSet[counter + 1]
        
        counter += 2
        
    }
    
    func getSet(max: Int) {
        let count = tableContent.count
        rIndex = randomIndex(of: count)
        print(count)
        print(rIndex)
        
        for i in 1...max {
            tableSet.append(tableContent[rIndex])
            tableSet.append(tableContent[rIndex + 1])
            
            
            tableContent.remove(at: rIndex)
            tableContent.remove(at: rIndex)
            
            
            rIndex = randomIndex(of: count)
        }
        print(tableSet)
    }
    
    func randomIndex(of: Int) -> Int {
        var randomIndex = Int.random(in: 0...of)
        
        while randomIndex % 2 != 0 {
            randomIndex = Int.random(in: 0...of)
        }
        
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
}


//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            GameView(multiplicationTable: .constant(5))
//        }
//    }
//}

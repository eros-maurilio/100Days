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
    @State var max: Int
    
    //@State var
    
    var body: some View {
        VStack {
            Spacer()
            Text("What is \(multiplying) x \(multiplier)?")
                .onAppear {
                    print("AQUIIIIIIII \(max)")
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
        var count = tableContent.count
//        print("da;ksd;askd;alskd;lak;das \(max)")
//        print(count)
        print("Primeiro rIndex: \(rIndex)")
//
//        print(tableContent)
        
        for _ in 1...max {
            count = tableContent.count
            
            rIndex = randomIndex(of: count)
            print("tableset: \(tableSet))")
            print("tableCotent: \(tableContent))")
            print("R INDEX: \(rIndex)")
            print("tablecontent Index \(tableContent[rIndex])")
            tableSet.append(tableContent[rIndex])
            tableSet.append(tableContent[rIndex + 1])
            
            
            tableContent.remove(at: rIndex)
            tableContent.remove(at: rIndex)
            print("first count: \(count)")
            if rIndex != 0 { count -= 2 }
            if count == 1 { count -= 1 }
            print("Count: \(count)")
            print("tableContent.count: \(tableContent.count)")
            print("Table content array: \(tableContent)")
            print("Random Indexx \(randomIndex(of: count))")
            print("-----------------------------------------------------------------------")
        }
        print(tableSet)
    }
    
    func randomIndex(of: Int) -> Int {
        var randomIndex: Int
        let count = of - 1
        
        repeat {
            randomIndex = Int.random(in: 0...count)
            if randomIndex == 0 {
                break
            }
            print("------------------randomIndex----------------")
            print(randomIndex)
            print("------------------randomIndex----------------")


        } while randomIndex % 2 != 0
        print(randomIndex)

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

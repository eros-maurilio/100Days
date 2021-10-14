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
    
//    @State var
    
    var body: some View {
        VStack {
            Spacer()
            Text("What is \(multiplying) x \(multiplier)?")
            
            
            Verification(code: $anwser)
                .animation(.spring())
                .onChange(of: anwser) { newValue in
                    print(anwser)
                }
        }
        .onAppear {
            getTable(upTo: multiplicationTable)
            getSet(max: 5)
        }
    }
    
    func getSet(max: Int) {
        let count = tableContent.count
        rIndex = randomIndex(of: count)

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


struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameView(multiplicationTable: .constant(5))
        }
    }
}

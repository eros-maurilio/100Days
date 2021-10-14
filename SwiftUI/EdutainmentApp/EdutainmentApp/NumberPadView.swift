//
//  SwiftUIView.swift
//  EdutainmentApp
//
//  Created by Eros Maurilio on 14/10/21.
//

import SwiftUI

struct NumberPadView: View {
   @State var code: [String]
    
    var body: some View {
        VStack(alignment: .center){
            Verification(code: $code)
        }
        .animation(.spring())
    }
}

struct Verification: View {
    @Binding var code: [String]

    var body: some View {
        VStack {
            Text("Enter the answer")
                .font(.title3)
            HStack(spacing: 20) {
                ForEach(code, id: \.self) {i in
                    Text(i)
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .padding(.vertical)
            }
            
            Spacer()
            
            numberPad(codes: $code)
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        NumberPadView()
//    }
//}

struct numberPad: View {
    @Binding var codes: [String]
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            ForEach(datas) { i in
                HStack() {
                    ForEach(i.row) { j in
                        Button {
                            if j.value == "delete.left.fill" && !codes.isEmpty{
                                self.codes.removeLast()
                                
                            } else {
                                if j.value != "delete.left.fill" && j.value != "L" {
                                    self.codes.append(j.value)
                                    
                                }
                                
                                if self.codes.count == 6 {
                                    self.codes.removeFirst()
                                }
                            }
                            
                        } label: {

                            
                            if j.value == "delete.left.fill" && j.value != "L"{
                                HStack {
                                    Spacer()
                                    Image(systemName: j.value)
                                        .font(.title3)
                                        .padding(.vertical)
                                    .padding(.leading, -8)
                                    Spacer()
                                }
                                .foregroundColor(.black)
                                .padding(2)

                            } else {
                                
                                if j.value == "L" {
                                    HStack {
                                        Spacer()
                                        Text(j.value)
                                            .font(.title)
                                        .foregroundColor(.clear)
                                        Spacer()
                                    }
                                    .padding(2)

                                    
                                } else {
                                
                                    HStack {
                                        Spacer()
                                        Text(j.value)
                                        .font(.title)
                                        .fontWeight(.semibold)
                                    .padding(.vertical)
                                        Spacer()

                                    }
                                    .foregroundColor(.black)
                                    .background(Color("Orange"))
                                    .cornerRadius(10)
                                    .padding(2)
                                }
                                
                            }
                        }
                    }
                }
                .padding(.horizontal, 30)
            }
        }
    }
    
    func getSpacing() -> CGFloat { UIScreen.main.bounds.width / 3 }

}


struct type: Identifiable {
    var id: Int
    var row: [row]
    
}

struct row: Identifiable {
    var id: Int
    var value: String
    
}

var datas = [
    type(id: 0, row: [row(id: 0, value: "1"), row(id: 1, value: "2"), row(id: 2, value: "3")]),
    type(id: 1, row: [row(id: 0, value: "4"), row(id: 1, value: "5"), row(id: 2, value: "6")]),
    type(id: 2, row: [row(id: 0, value: "7"), row(id: 1, value: "8"), row(id: 2, value: "9")]),
    type(id: 3, row: [row(id: 0, value: "L"), row(id: 1, value: "0"), row(id: 2, value: "delete.left.fill")])
    
    
    
]

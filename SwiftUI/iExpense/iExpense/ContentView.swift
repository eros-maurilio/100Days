//
//  ContentView.swift
//  iExpense
//
//  Created by Eros Maurilio on 20/10/21.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
    
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpanse = false
    @State private var rowColor: Color = .clear
    @State private var foreColor: Color = .black
    
    var body: some View {
        NavigationView {
            List{
                ForEach(expenses.items) { item in
                    switch item.amount {
                    case 100...:
                        row(name: item.name, type: item.type, amount: item.amount)
                            .foregroundColor(.red)
                        
                    case 10..<100:
                        row(name: item.name, type: item.type, amount: item.amount)
                            .foregroundColor(.yellow)
                        
                    case ..<10:
                        row(name: item.name, type: item.type, amount: item.amount)
                            .foregroundColor(.green)
                        
                    default:
                        row(name: item.name, type: item.type, amount: item.amount)
                            .foregroundColor(.black)
                    }
                    
                    
                    
                }
                .onDelete(perform: removeItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.showingAddExpanse = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) { EditButton() }
                }
            .sheet(isPresented: $showingAddExpanse) {
                AddView(expenses: self.expenses)
            }
            .navigationTitle("iExpanse")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func setupRow(amount: Int) {
        switch amount {
        case 100...:
            rowColor = .red
            foreColor = .white
            
        case 10..<100:
            rowColor = .yellow
            foreColor = .black
        
        case ..<10:
            rowColor = .green
            foreColor = .black
            
        default:
            rowColor = .clear
            foreColor = .white
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct row: View {
    var name: String
    var type: String
    var amount: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                Text(type)
                
            }
            Spacer()
            
            Text("$\(amount)")
            
        }
    }
}

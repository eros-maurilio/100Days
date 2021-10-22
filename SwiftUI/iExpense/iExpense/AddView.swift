//
//  AddView.swift
//  iExpense
//
//  Created by Eros Maurilio on 21/10/21.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    @State private var isShowingAlert = false
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("This is not correct"), message: Text("In the amount field only numbers must be added!"), dismissButton: .default(Text("OK"), action: {
                    amount = ""
                }))
            }
            .navigationTitle("Add new expense")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if let actualAmount = Int(self.amount) {
                            let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                            self.expenses.items.append(item)
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            isShowingAlert = true
                        }
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

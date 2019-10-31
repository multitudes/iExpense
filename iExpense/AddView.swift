//
//  SwiftUIView.swift
//  iExpense
//
//  Created by Laurent B on 30/10/2019.
//  Copyright © 2019 Laurent B. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var expenses: Expenses
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingAlert = false
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    static var types = ["Business", "Personal"]
    
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
            .navigationBarTitle("Add new expense")
                .navigationBarItems(trailing: Button("Save") {
                    if let actualAmount = Int(self.amount) {
                        let today = Date()
                        let formatter = DateFormatter()
                        formatter.dateStyle = .medium
                        let item = ExpenseItem(todaysDate: formatter.string(from: today), name: self.name, type: self.type, amount: actualAmount)
                        
                        self.expenses.items.append(item)
                        self.presentationMode.wrappedValue.dismiss()
                        //reset values
                        self.name = ""
                        self.amount = ""
                        print(item)
                    } else {
                        self.showingAlert = true
                    }
                })
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("🎃"), message: Text("This is not a valid number!"), dismissButton: .default(Text("OK!")))
            
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

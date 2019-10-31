//
//  ContentView.swift
//  iExpense
//
//  Created by Laurent B on 29/10/2019.
//  Copyright © 2019 Laurent B. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let todaysDate: String
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
    @State private var showingAddExpense = false
    
    let col: Color = Color(red: 0.2, green: 0.5, blue: 0.9, opacity: 0.5)
    let fontCol: Color = Color(hue: 0.545, saturation: 0.361, brightness: 1.0)
    let expenseColor = Color(.systemBlue)
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items){ item in
                    HStack{
                        VStack(alignment: .leading) {
                            Text("Date: \(item.todaysDate)")
                                .font(.headline)
                                .padding(.top)
                                .lineLimit(nil)
                            
                            Text(item.name)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)").font(.system(size: 32))
                    }
                    .listRowBackground(item.type == "Personal" ? Color(.systemBlue) : Color(.systemOrange))
                    .foregroundColor(Color.white)
                    
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense" )
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showingAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: self.expenses)
            }
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

//
//  ContentView.swift
//  iExpense
//
//  Created by Laurent B on 29/10/2019.
//  Copyright © 2019 Laurent B. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var numbers = [Int]()
    @State var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                            Text("\($0)")
                    }.onDelete(perform: removeRows)
                }
                
                Button("Add Number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
                
                
            }.navigationBarItems(leading: EditButton())
        }
    }
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

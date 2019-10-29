//
//  ContentView.swift
//  iExpense
//
//  Created by Laurent B on 29/10/2019.
//  Copyright © 2019 Laurent B. All rights reserved.
//

import SwiftUI

struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @State var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    @State var user = User(firstName: "Taylor", lastName: "Swift")
    var body: some View {
        Button("Tap Count: \(tapCount)") {
            self.tapCount += 1
            UserDefaults.standard.set(self.tapCount, forKey: "Tap")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

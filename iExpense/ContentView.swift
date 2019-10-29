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
    
    @State var user = User(firstName: "Taylor", lastName: "Swift")
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        Button("Save User") {
            
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(self.user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
            
            if let savedUser = self.defaults.object(forKey: "UserData") as? Data {
                let decoder = JSONDecoder()
                if let loadedPerson = try? decoder.decode(User.self, from: savedUser) {
                    print(loadedPerson.firstName)
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 

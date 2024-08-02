// Created by brainfck on 8/2/24.

import SwiftUI

struct ContentView: View {
  var body: some View {
    Button("Decode JSON") {
      let input = """
      {
        "name": "Taylor Swift",
        "address": {
          "street": "555, Taylor Swift Avenue",
          "city": "Nashvile"
        }
      }
      """
      
      let data = Data(input.utf8)
      let decoder = JSONDecoder()
      if let user = try? decoder.decode(User.self, from: data) {
        print(user.address.street)
      }
    }
  }
}

struct User: Codable {
  let name: String
  let address: Address
}

struct Address: Codable {
  let street: String
  let city: String
}

#Preview {
  ContentView()
}

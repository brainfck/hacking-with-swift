// Created by brainfck on 7/29/24.

import SwiftUI

struct ContentView: View {
  @State private var user = User()
  
  var body: some View {
    VStack {
      Text("Your name is: \(user.firstName) \(user.lastName).")
      
      TextField("First name", text: $user.firstName)
      TextField("Last name", text: $user.lastName)
    }
    .padding()
  }
}

// class instead of struct because we want to share data between different views
@Observable
class User {
  var firstName = "Bilbo"
  var lastName = "Baggins"
}

#Preview {
  ContentView()
}

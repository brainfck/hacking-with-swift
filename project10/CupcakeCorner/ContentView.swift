// Created by brainfck on 9/2/24.

import SwiftUI

struct ContentView: View {
  @State private var username = ""
  @State private var email = ""
  
  var disabledForm: Bool {
    username.count < 5 || email.count < 5
  }
  
  var body: some View {
    Form {
      Section {
        TextField("Username", text: $username)
        TextField("Email", text: $email)
      }
      
      Section {
        Button("Create account") {
          print("Creating account")
        }
      }
      .disabled(disabledForm)
    }
  }
}


#Preview {
  ContentView()
}

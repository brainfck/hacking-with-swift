// Created by brainfck on 8/27/24.

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack {
      Text("Hello, World!")
      .toolbar {
        ToolbarItemGroup(placement: .topBarLeading) {
          Button("Tap me") {
            
          }
          Button("Tap me 2") {
            
          }
        }
        
        ToolbarItem(placement: .topBarLeading) {
          Button("Tap me") {
            
          }
        }
        
        ToolbarItem(placement: .topBarLeading) {
          Button("Or Tap me") {
            
          }
        }
      }
    }
  }
}


#Preview {
  ContentView()
}

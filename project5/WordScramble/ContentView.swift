// Created by brainfck on 7/22/24.

import SwiftUI

struct ContentView: View {
  var body: some View {
    List {
      Section("Section 1") {
        Text("Static row 1")
        Text("Static row 2")
        
      }
      
      Section("Section 2") {
        ForEach(0..<5) {
          Text("Dynamic row \($0)")
        }
      }
      
      Section("Section 3") {
        Text("Static row 3")
        Text("Static row 4")
      }
    }
    .listStyle(.grouped)
    
    List(0..<5) {
      Text("Dynamic row \($0)")
    }
  }
}

#Preview {
  ContentView()
}

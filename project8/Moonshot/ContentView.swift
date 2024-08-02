// Created by brainfck on 8/2/24.

import SwiftUI

struct ContentView: View {
  var body: some View {
    ScrollView {
      LazyVStack(spacing: 10) {
        ForEach(0..<100) {
          CustomText("Item \($0)")
            .font(.title)
        }
      }
      .frame(maxWidth: .infinity)
    }
  }
}

struct CustomText: View {
  let text: String
  
  var body: some View {
    Text(text)
  }
  
  init(_ text: String) {
    print("Creating a new CustomText")
    self.text = text
  }
}

#Preview {
  ContentView()
}

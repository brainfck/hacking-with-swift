// Created by brainfck on 7/10/24.

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
              .titleStyle()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
    }
}

struct Title: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.largeTitle)
      .foregroundStyle(.blue)
      .padding()
  }
}

extension View {
  func titleStyle() -> some View {
    modifier(Title())
  }
}

#Preview {
    ContentView()
}

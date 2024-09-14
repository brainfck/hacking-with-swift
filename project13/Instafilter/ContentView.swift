// Created by brainfck on 9/14/24.

import SwiftUI

struct ContentView: View {
  @State private var showingConfirmation = false
  @State private var backgroudColor = Color.white

  var body: some View {
    Button("Hello world!") {
      showingConfirmation = true
    }
    .frame(width: 300, height: 300)
    .background(backgroudColor)
    .confirmationDialog("Change background", isPresented: $showingConfirmation) {
      Button("Red") { backgroudColor = .red }
      Button("Green") { backgroudColor = .green }
      Button("Blue") { backgroudColor = .blue }
      Button("Cancel", role: .cancel) {}
    } message: {
      Text("Select new color")
    }
  }
}

#Preview {
  ContentView()
}

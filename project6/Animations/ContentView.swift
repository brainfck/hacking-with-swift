// Created by brainfck on 7/23/24.

import SwiftUI

struct ContentView: View {
  @State private var isShowingRed = false
  
  var body: some View {
    VStack {
      Button("Tap me") {
        withAnimation {
          isShowingRed.toggle()
        }
      }
      
      if isShowingRed {
        Rectangle()
          .fill(.red)
          .frame(width: 200, height: 200)
          .transition(.asymmetric(insertion: .scale, removal: .opacity))
      }
    }
  }
}

#Preview {
  ContentView()
}

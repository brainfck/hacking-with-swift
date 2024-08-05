// Created by brainfck on 8/2/24.

import SwiftUI

struct ContentView: View {
  let astronauts = Bundle.main.decode("astronauts.json")
  
  var body: some View {
    VStack {
      Text(String(astronauts.count))
    }
  }
}


#Preview {
  ContentView()
}

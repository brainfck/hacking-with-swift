// Created by brainfck on 8/2/24.

import SwiftUI

struct ContentView: View {
  let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
  let missions: [Mission] = Bundle.main.decode("missions.json")
  
  var body: some View {
    VStack {
      Text(String(astronauts.count))
      Text(String(missions.count))
    }
  }
}


#Preview {
  ContentView()
}

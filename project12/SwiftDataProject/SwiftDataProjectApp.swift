// Created by brainfck on 9/10/24.

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for: User.self)
  }
}

// Created by brainfck on 9/7/24.

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for: Student.self)
  }
}

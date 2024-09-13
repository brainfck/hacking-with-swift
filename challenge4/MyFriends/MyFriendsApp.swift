// Created by brainfck on 9/12/24.

import SwiftData
import SwiftUI

@main
struct MyFriendsApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for: [User.self, ])
  }
}

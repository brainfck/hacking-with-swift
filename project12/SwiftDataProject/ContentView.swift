// Created by brainfck on 9/10/24.

import SwiftData
import SwiftUI

struct ContentView: View {
  @Environment(\.modelContext) var modelContext
  
  @State private var showingUpcomingOnly = false
  
  @State private var sortOrder = [
    SortDescriptor(\User.name),
    SortDescriptor(\User.joinDate),
  ]
  
  @Query(filter: #Predicate<User> { user in
    user.name.localizedStandardContains("R") &&
      user.city == "London"
  }, sort: \User.name) var users: [User]

  var body: some View {
    NavigationStack {
      UsersView(minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
        .navigationTitle("Users")
        .toolbar {
          //Button("Add Samples", action: addSample)
          
          Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
            showingUpcomingOnly.toggle()
          }
        
          Menu("Sort", systemImage: "arrow.up.arrow.down") {
            Picker("Sort", selection: $sortOrder) {
              Text("Sort by Name")
                .tag([
                  SortDescriptor(\User.name),
                  SortDescriptor(\User.joinDate),
                ])
            
              Text("Sort by Join Date")
                .tag([
                  SortDescriptor(\User.joinDate),
                  SortDescriptor(\User.name),
                ])
            }
          }
        }
    }
  }
  
  func addSample() {
    let user1 = User(name: "Piper Chapman", city: "New York", joinDate: .now)
    let job1 = Job(name: "Organize sock drawer", priority: 3)
    let job2 = Job(name: "Make plans with Alex", priority: 4)
    
    modelContext.insert(user1)
    
    user1.jobs.append(job1)
    user1.jobs.append(job2)
  }
}

#Preview {
  let previewContainer = try! ModelContainer(for: User.self)
  
  return ContentView()
    .modelContainer(previewContainer)
}

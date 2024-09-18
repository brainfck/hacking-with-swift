//
//  ContentView.swift
//  BucketList
//
//  Created by Mykhailo Tsuber on 9/18/24.
//

import SwiftUI

struct ContentView: View {
  @State private var loadingState = LoadingState.loading
  
  enum LoadingState {
    case loading, success, failed
  }
  
  var body: some View {
    switch loadingState {
    case .loading:
      LoadingView()
    case .success:
      SuccessView()
    case .failed:
      FailedView()
    }
  }
}

struct LoadingView: View {
  var body: some View {
    Text("Loading...")
  }
}

struct SuccessView: View {
  var body: some View {
    Text("Success!")
  }
}

struct FailedView: View {
  var body: some View {
    Text("Failed.")
  }
}

//struct ContentView: View {
//  var body: some View {
//    Button("Read and Write") {
//      let data = Data("Test Message".utf8)
//      let url = URL.documentsDirectory.appending(path: "message.txt")
//      
//      do {
//        try data.write(to: url, options: [.atomic, .completeFileProtection])
//        let input = try String(contentsOf: url, encoding: .utf8)
//        print(input)
//      } catch {
//        print(error.localizedDescription)
//      }
//    }
//  }
//}

//struct ContentView: View {
//  let users: [User] = [
//    .init(firstName: "Arnorld", lastName: "Rimmer"),
//    .init(firstName: "Kristine", lastName: "Kochanski"),
//    .init(firstName: "David", lastName: "Lister"),
//  ].sorted()
//  
//  var body: some View {
//    List(users) { user in
//      Text("\(user.lastName), \(user.firstName)")
//    }
//  }
//}
//
//struct User: Identifiable, Comparable {
//  let id = UUID()
//  var firstName: String
//  let lastName: String
//  
//  static func < (lhs: User, rhs: User) -> Bool {
//    lhs.lastName < rhs.lastName
//  }
//}

#Preview {
  ContentView()
}

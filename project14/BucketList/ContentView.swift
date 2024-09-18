//
//  ContentView.swift
//  BucketList
//
//  Created by Mykhailo Tsuber on 9/18/24.
//

import SwiftUI

struct ContentView: View {
  let users: [User] = [
    .init(firstName: "Arnorld", lastName: "Rimmer"),
    .init(firstName: "Kristine", lastName: "Kochanski"),
    .init(firstName: "David", lastName: "Lister"),
  ].sorted()
  
  var body: some View {
    List(users) { user in
      Text("\(user.lastName), \(user.firstName)")
    }
  }
}

struct User: Identifiable, Comparable {
  let id = UUID()
  var firstName: String
  let lastName: String
  
  static func < (lhs: User, rhs: User) -> Bool {
    lhs.lastName < rhs.lastName
  }
}

#Preview {
  ContentView()
}

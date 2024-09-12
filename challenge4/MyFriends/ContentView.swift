// Created by brainfck on 9/12/24.

import SwiftUI

struct ContentView: View {
  // @StateObject: Keeps the MyDataViewModel alive throughout the view’s lifecycle.
  @StateObject private var viewModel = UsersViewModel()

  var body: some View {
    NavigationStack {
      List(viewModel.users) { user in

        NavigationLink(value: user) {
          VStack(alignment: .leading) {
            Text(user.name)
              .font(.headline)
            HStack {
              Text(user.email)
                .font(.subheadline)
              Text(user.isActive ? "Active" : "InActive")
                .foregroundStyle(user.isActive ? .green : .red)
            }
          }
        }
      }
      .navigationTitle("My Friends")
      .navigationDestination(for: User.self) { user in
        UserDetailView(user: user)
      }
    }

    .onAppear {
      viewModel.fetchData()
    }
  }
}

#Preview {
  ContentView()
}

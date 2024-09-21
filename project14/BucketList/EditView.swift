//
//  EditView.swift
//  BucketList
//
//  Created by Mykhailo Tsuber on 9/21/24.
//

import SwiftUI

struct EditView: View {
  @Environment(\.dismiss) var dismiss
  var location: Location

  @State private var name: String
  @State private var description: String

  init(location: Location, onSave: @escaping (Location) -> Void) {
    self.location = location
    self.onSave = onSave

    _name = State(initialValue: location.name)
    _description = State(initialValue: location.description)
  }

  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("Place name", text: $name)
          TextField("Descsription", text: $description)
        }
      }
      .navigationTitle("Place details")
      .toolbar {
        Button("Save") {
          var newLocation = location
          newLocation.name = name
          newLocation.description = description
          newLocation.id = UUID()
          
          onSave(newLocation)
          dismiss()
        }
      }
    }
  }

  var onSave: (Location) -> Void
}

#Preview {
  EditView(location: .example) { _ in }
}

// Created by brainfck on 9/12/24.

import Foundation

struct User: Identifiable, Codable, Hashable {
  var id: UUID
  var isActive: Bool
  var name: String
  var age: Int
  var company: String
  var email: String
  var address: String
  var about: String
  var registered: Date
  var tags: [String]
  var friends: [Friend]

  var formattedDate: String {
    let formatter = DateFormatter()

    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    formatter.locale = Locale.current

    return formatter.string(from: registered)
  }
}

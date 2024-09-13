// Created by brainfck on 9/12/24.

import Foundation
import SwiftData

@Model
class Friend: Codable {
  var id: UUID
  var name: String

  init(id: UUID, name: String) {
    self.id = id
    self.name = name
  }

  required init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(UUID.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
  }

  enum CodingKeys: CodingKey {
    case id
    case name
  }

  func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.id, forKey: .id)
    try container.encode(self.name, forKey: .name)
  }
}

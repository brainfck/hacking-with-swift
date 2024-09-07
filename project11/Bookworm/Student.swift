// Created by brainfck on 9/7/24.

import Foundation
import SwiftData

@Model
class Student: Identifiable {
  var id: UUID
  var name: String
  
  init(id: UUID, name: String) {
    self.id = id
    self.name = name
  }
}

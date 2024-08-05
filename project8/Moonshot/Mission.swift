// Created by brainfck on 8/5/24.

struct Mission: Codable, Identifiable {
  struct CrewRole: Codable {
    let name: String
    let role: String
  }
  
  let id: Int
  let launchDate: String?
  let crew: [CrewRole]
  let description: String
}

// Created by brainfck on 9/12/24.

import Foundation

// use ObservableObject for your data model, like MyDataViewModel, when you want to make it observable by SwiftUI views.
class UsersViewModel: ObservableObject {
  // @Published: Automatically updates the view when new data is loaded.
  @Published var users = [User]()
  
  func fetchData() {
    if !users.isEmpty {
      return
    }
    
    guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
      print("Invalid URL")
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        print("Error fetching data: \(error)")
        return
      }
      
      guard let data = data else {
        print("No data received")
        return
      }
      
      if let jsonString = String(data: data, encoding: .utf8) {
        print("Raw JSON Response: \(jsonString)")
      }
      
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      
      do {
        let decodedData = try decoder.decode([User].self, from: data)
        DispatchQueue.main.async {
          self.users = decodedData
        }
      } catch {
        print("Error decoding JSON: \(error.localizedDescription)")
      }
    }
    
    task.resume()
  }
}

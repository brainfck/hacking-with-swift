import Foundation
import SwiftData

class UsersViewModel: ObservableObject {
  @Published var users = [User]()
  
  func loadUsers(context: ModelContext) {
    // Define a FetchDescriptor for User
    let fetchDescriptor = FetchDescriptor<User>()
    
    do {
      // Fetch users using the descriptor
      users = try context.fetch(fetchDescriptor)
    } catch {
      print("Error fetching users: \(error.localizedDescription)")
    }
    
    // If no users are found, fetch from the API
    if users.isEmpty {
      fetchFromAPI(context: context)
    }
  }
  
  private func fetchFromAPI(context: ModelContext) {
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
      
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      
      do {
        let decodedUsers = try decoder.decode([User].self, from: data)
        
        // Save users to SwiftData
        DispatchQueue.main.async {
          // Insert data into context
          for user in decodedUsers {
            context.insert(user)
          }
          
          do {
            try context.save() // Save changes to the context
            self.users = decodedUsers
          } catch {
            print("Error saving users: \(error.localizedDescription)")
          }
        }
      } catch {
        print("Error decoding JSON: \(error.localizedDescription)")
      }
    }
    task.resume()
  }
}

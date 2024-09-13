import SwiftUI
import SwiftData

struct UserDetailView: View {
  let user: User
  
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
  ]
  
  let friendsColumns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
  ]
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 20) {
        // Name
        Text(user.name)
          .font(.largeTitle)
          .fontWeight(.bold)
        
        // Age, Company, and Email
        HStack {
          VStack(alignment: .leading, spacing: 5) {
            Text("Age: \(user.age)")
            Text("Company: \(user.company)")
          }
          .font(.subheadline)
          
          Spacer()
          
          VStack(alignment: .trailing, spacing: 5) {
            Text(user.email)
              .foregroundColor(.blue)
              .underline()
          }
          .font(.subheadline)
        }
        
        // Address and Registered Date
        HStack {
          VStack(alignment: .leading, spacing: 5) {
            Text(user.address)
            Text("Registered: \(user.formattedDate)")
              .font(.footnote)
              .foregroundColor(user.isActive ? .green.opacity(0.8) : .red.opacity(0.5))
          }
          
          Spacer()
        }
        
        // About
        Text(user.about)
          .font(.body)
          .foregroundColor(.secondary)
          .lineLimit(nil)
        
        // Tags
        VStack(alignment: .leading) {
          Text("Tags")
            .font(.headline)
            .padding(.bottom, 5)
          
          LazyVGrid(columns: columns, spacing: 10) {
            ForEach(user.tags, id: \.self) { tag in
              Text(tag)
                .padding(8)
                .background(Color.blue.opacity(0.2))
                .foregroundColor(.blue)
                .cornerRadius(8)
            }
          }
          .font(.subheadline)
        }
        
        // Friends
        VStack(alignment: .leading) {
          Text("Friends")
            .font(.headline)
            .padding(.bottom, 5)
          
          LazyVGrid(columns: friendsColumns, spacing: 10) {
            ForEach(user.friends) { friend in
              Text(friend.name)
                .padding(8)
                .background(Color.green.opacity(0.2))
                .foregroundColor(.green)
                .cornerRadius(8)
            }
          }
          .font(.subheadline)
        }
      }
      .scrollBounceBehavior(.basedOnSize)
      .padding()
    }
  }
}

#Preview {
  do {
    // Create in-memory model configuration
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    
    // Initialize the ModelContainer with both User and Friend models
    let container = try ModelContainer(for: User.self, Friend.self, configurations: config)
    
    // Create instances of Friend
    let friend1 = Friend(id: UUID(), name: "Alice")
    let friend2 = Friend(id: UUID(), name: "Bob")
    
    // Create an instance of User with friends
    let exampleUser = User(
      id: UUID(),
      isActive: true,
      name: "Test User",
      age: 25,
      company: "Test Company",
      email: "testuser@example.com",
      address: "123 Test Street",
      about: "This is a test user profile.",
      registered: Date(),
      tags: ["tag1", "tag2"],
      friends: [friend1, friend2]  // Initialize relationship
    )
    
    // Insert the user into the container to make the relationship active
    let context = container.mainContext
    try context.insert(exampleUser)
    try context.save()
    
    return UserDetailView(user: exampleUser)
      .modelContainer(container)
  } catch {
    return Text("Failed to create preview: \(error.localizedDescription)")
  }
}

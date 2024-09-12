import SwiftUI

struct UserDetailView: View {
  let user: User
  
  let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible())
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
          
          LazyVGrid(columns: columns, spacing: 10) {
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
  let example = User(
    id: UUID(),
    isActive: true,
    name: "Test",
    age: 20,
    company: "Test Company",
    email: "test@gmail.com",
    address: "Test street 12, asdsa",
    about: "Test about long text something something",
    registered: .now,
    tags: ["one", "two", "three"],
    friends: [Friend(id: UUID(), name: "Alice"), Friend(id: UUID(), name: "Bob")]
  )
  
  return UserDetailView(user: example)
}

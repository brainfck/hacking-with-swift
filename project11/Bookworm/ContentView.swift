// Created by brainfck on 9/7/24.

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) var modelContext
  @Query var books: [Book]
  
  @State private var showingAddScreen = false
  
  var body: some View {
    NavigationStack {
      List {
        ForEach(books) { book in
          NavigationLink(value: book) {
            HStack {
              EmojiRatingView(rating: book.rating)
                .font(.largeTitle)
              
              VStack(alignment: .leading) {
                Text(book.title)
                  .font(.headline)
                Text(book.author)
                  .foregroundStyle(.secondary)
              }
            }
          }
        }
      }
      .navigationTitle("Bookworm")
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Add Book", systemImage: "plus") {
            showingAddScreen.toggle()
          }
        }
      }
      .sheet(isPresented: $showingAddScreen) {
        AddBookView()
      }
    }
  }
}

#Preview {
  let previewContainer = try! ModelContainer(for: Book.self)
  
  return ContentView()
    .modelContainer(previewContainer)
}

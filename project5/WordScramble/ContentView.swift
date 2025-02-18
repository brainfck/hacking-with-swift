// Created by brainfck on 7/22/24.

import SwiftUI

struct ContentView: View {
  @State private var usedWords = [String]()
  @State private var rootWord = ""
  @State private var newWord = ""
  
  @State private var errorTitle = ""
  @State private var errorMessage = ""
  @State private var showingError = false
  
  @State private var userScore = 0
  
  var body: some View {
    NavigationStack {
      List {
        Section("Score: \(userScore)"){
          TextField("Enter your word", text: $newWord)
            .textInputAutocapitalization(.never)
        }
        
        Section {
          ForEach(usedWords, id: \.self) { word in
            HStack{
              Image(systemName: "\(word.count).circle")
              Text(word)
            }
          }
        }
      }
      .navigationTitle(rootWord)
      .onSubmit(addNewWord)
      .onAppear(perform: startGame)
      .alert(errorTitle, isPresented: $showingError) { } message: {
        Text(errorMessage)
      }
      .toolbar {
        Button("Restart", action: startGame)
      }
    }
  }
  
  func addNewWord() {
    let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
    
    guard answer.count > 0 else { return }
    guard isOriginal(word: answer) else {
      wordError(title: "Word used already", message: "Be more original")
      return
    }
    guard isLongEnough(word: answer) else {
      wordError(title: "Word is not long enough", message: "Use a word of more than 3 letters")
      return
    }
    guard isPossible(word: answer) else {
      wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
      return
    }
    guard isReal(word: answer) else {
      wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
      return
    }
    
    userScore += 1 + answer.count
    
    withAnimation {
      usedWords.insert(answer, at: 0)
    }
    
    newWord = ""
  }
  
  func startGame() {
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
      if let startWords = try? String(contentsOf: startWordsURL) {
        let allWords = startWords.components(separatedBy: "\n")
        
        rootWord = allWords.randomElement() ?? "silkworm"
        
        return
      }
    }
    
    fatalError("Could not load start.txt from bundle.")
  }
  
  func isOriginal(word: String) -> Bool {
    !usedWords.contains(word) && word != rootWord
  }
  
  func isPossible(word: String) -> Bool {
    var tempWord = rootWord
    
    for letter in word {
      if let pos = tempWord.firstIndex(of: letter) {
        tempWord.remove(at: pos)
      } else {
        return false
      }
    }
    
    return true
  }
  
  func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    
    return misspelledRange.location == NSNotFound
  }
  
  func isLongEnough(word: String) -> Bool {
    return word.count > 3
  }
  
  func wordError(title: String, message: String) {
    errorTitle = title
    errorMessage = message
    showingError = true
  }
}

#Preview {
  ContentView()
}

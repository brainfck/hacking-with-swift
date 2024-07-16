// Created by brainfck on 7/16/24.

import SwiftUI

struct ContentView: View {
  
  let moves = ["🗿", "💵", "✂️"]
  let winningMoves = ["💵", "✂️", "🗿"]
  let loosingMoves = ["✂️", "🗿", "💵"]
  
  let maxMoves = 10
  
  @State private var winGoal = Bool.random()
  @State private var currentMove = Int.random(in: 0...2)
  @State private var userScore = 0
  @State private var movesCounter = 0
  @State private var showingScore = false
  @State private var showingFinal = false
  @State private var scoreTitle = ""
  
  var correctMove: String {
    if winGoal {
      return winningMoves[currentMove]
    } else {
      return loosingMoves[currentMove]
    }
  }
  
  var body: some View {
    ZStack {
      RadialGradient(stops: [
        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
      ], center: .top, startRadius: 200, endRadius: 400)
      .ignoresSafeArea()
      
      VStack {
        Text(userScore >= movesCounter ? "😭" : "")
        
        HStack {
          Text(winGoal ? "Win" : "Loose")
            .fontWeight(.bold)
          Text("vs")
          MoveView(text: moves[currentMove])
        }
        
        HStack {
          ForEach(moves, id: \.self) { move in
            Button {
              moveTapped(move)
            } label: {
              MoveView(text: move)
            }
          }
        }
        Text("Score: \(userScore) of \(movesCounter)")
        
      }
      .padding()
    }
    .alert(scoreTitle, isPresented: $showingScore) {
      Button("I want more", action: makeMove)
    } message: {
      Text("Your score is \(userScore)")
    }
    .alert("Game Over", isPresented: $showingFinal) {
      Button("Reset", action: resetGame)
    } message: {
      Text("Game over. You scored")
    }
  }
  
  func moveTapped(_ move: String) {
    movesCounter += 1
    
    if move == correctMove {
      userScore += 1
      scoreTitle = "Winner"
    } else {
      scoreTitle = "LOOSER"
    }
    
    if movesCounter >= maxMoves {
      showingFinal = true
    } else {
      showingScore = true
    }
  }
  
  func makeMove() {
    winGoal = Bool.random()
  }
  
  func resetGame() {
    userScore = 0
    movesCounter = 0
    showingFinal = false
    makeMove()
  }
}

struct MoveView: View {
  var text: String
  
  var body: some View {
    Text(text)
      .font(.largeTitle)
      .shadow(radius: 30)
      .padding()
  }
}

#Preview {
  ContentView()
}

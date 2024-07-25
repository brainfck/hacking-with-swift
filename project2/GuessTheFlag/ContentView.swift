// Created by brainfck on 7/7/24.

import SwiftUI

struct ContentView: View {
  
  @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
  
  @State private var correctAnswer = Int.random(in: 0...2)
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var userScore = 0
  @State private var questionsCounter = 0
  @State private var showingFinal = false
  
  @State private var animationAmount = [0.0, 0.0, 0.0]
  @State private var opacityAmount = [1.0, 1.0, 1.0]
  @State private var scaleAmount = [1.0, 1.0, 1.0]
  
  private let maximumQuestion = 8
  
  var body: some View {
    ZStack {
      RadialGradient(stops: [
        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
      ], center: .top, startRadius: 200, endRadius: 400)
        .ignoresSafeArea()
      
      VStack {
        Text("Guess the flag")
          .font(.largeTitle.weight(.bold))
          .foregroundStyle(.white)
        
        Spacer()
        
        VStack(spacing: 15) {
          VStack {
            Text("Tap the flag of")
              .foregroundStyle(.secondary)
              .font(.subheadline.weight(.heavy))
            Text(countries[correctAnswer])
              .font(.largeTitle.weight(.semibold))
          }
          
          ForEach(0..<3) { number in
            Button {
              flagTapped(number)
            } label: {
              FlagView(title: countries[number])
            }
            .rotation3DEffect(
              .degrees(animationAmount[number]),
              axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
            )
            .opacity(opacityAmount[number])
            .scaleEffect(scaleAmount[number])
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 20))
        
        Spacer()
        Spacer()
        Text("Score: \(userScore) of \(questionsCounter)")
          .foregroundStyle(.white)
          .font(.title.bold())
        Spacer()
      }
      .padding()
    }
    .alert(scoreTitle, isPresented: $showingScore) {
      Button("Continue", action: askQuestion)
    } message: {
      Text("Your score is \(userScore)")
    }
    .alert("Game Over", isPresented: $showingFinal) {
      Button("Reset", action: resetGame)
    } message: {
      Text("Game Over. Score is \(userScore) of \(maximumQuestion)")
    }
  }
  
  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      userScore += 1
    } else {
      scoreTitle = "Wrong, that's the flag of \(countries[number])"
    }
    
    withAnimation {
      animationAmount[number] += 360
      opacityAmount[number] = 1.0
      opacityAmount[(number + 1) % 3] = 0.25
      opacityAmount[(number + 2) % 3] = 0.25
      
      scaleAmount[(number + 1) % 3] = 0.25
      scaleAmount[(number + 2) % 3] = 0.25
    }
    
    questionsCounter += 1
    
    if(questionsCounter >= maximumQuestion) {
      showingFinal = true
    } else {
      showingScore = true
    }
  }
  
  func resetGame() {
    userScore = 0
    questionsCounter = 0
    showingFinal = false
    askQuestion()
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
    
    withAnimation {
      opacityAmount = [1.0, 1.0, 1.0]
      scaleAmount = [1.0, 1.0, 1.0]
    }
  }
}

struct FlagView: View {
  var title: String
  
  var body: some View {
    Image(title)
      .clipShape(.rect(cornerRadius: 10))
      .shadow(radius: 5)
  }
}

#Preview {
  ContentView()
}

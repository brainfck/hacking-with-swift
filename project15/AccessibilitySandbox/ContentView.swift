//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Mykhailo Tsuber on 9/26/24.
//

import SwiftUI

struct ContentView: View {
  @State private var value = 10
  
  var body: some View {
    VStack {
      Text("Value: \(value)")
      
      Button("Increment") {
        value += 1
      }
      
      Button("Decrement") {
        value -= 1
      }
    }
    .accessibilityElement()
    .accessibilityLabel("Value")
    .accessibilityValue(String(value))
    .accessibilityAdjustableAction { direction in
      switch direction {
      case .increment:
        value += 1
      case .decrement:
        value -= 1
      default:
        print("Not handled.")
      }
    }
  }
}

//struct ContentView: View {
//  var body: some View {
//    VStack {
//      Text("Your score is")
//      Text("1000")
//        .font(.title)
//    }
//    .accessibilityElement(children: .ignore)
//    .accessibilityLabel("Your score is 1000")
//  }
//}

//struct ContentView: View {
//  let pictures = [
//    "ales-krivec-15949",
//    "galina-n-189483",
//    "kevin-horstmann-141705",
//    "nicolas-tissot-335096"
//  ]
//  
//  let labels = [
//    "Tulips",
//    "Frozen tree buds",
//    "Sunflowers",
//    "Fireworks",
//  ]
//  
//  @State private var selectedPicture = Int.random(in: 0...3)
//  
//  var body: some View {
//    Button {
//      selectedPicture = Int.random(in: 0...3)
//    } label: {
//      Image(pictures[selectedPicture])
//        .resizable()
//        .scaledToFit()
//    }
//    .accessibilityLabel(labels[selectedPicture])
//  }
//}

#Preview {
  ContentView()
}

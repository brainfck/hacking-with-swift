//
//  ContentView.swift
//  BucketList
//
//  Created by Mykhailo Tsuber on 9/18/24.
//

import MapKit
import SwiftUI
import LocalAuthentication

struct ContentView: View {
  @State private var position = MapCameraPosition.region(
    MKCoordinateRegion(
      center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
      span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    )
  )

  @State private var isUnlocked = false
  
  let locations = [
    Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
    Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
  ]

  var body: some View {
    VStack {
      if isUnlocked {
        Text("Unlocked")
      } else {
        Text("Locked")
      }
    }
    .onAppear(perform: authenticate)
  }
  
//  var body: some View {
//    VStack {
////      Map {
////        ForEach(locations) { location in
////          Annotation(location.name, coordinate: location.coordinate) {
////            Text(location.name)
////              .font(.headline)
////              .padding()
////              .background(.blue)
////              .foregroundColor(.white)
////              .clipShape(.capsule)
////          }
////          .annotationTitles(.hidden)
////        }
////      }
//
//      MapReader { proxy in
//        Map()
//          .onTapGesture { position in
//            if let coordinate = proxy.convert(position, from: .local) {
//              print(coordinate)
//            }
//          }
//      }
//
//      HStack(spacing: 50) {
//        Button("Paris") {
//          position = MapCameraPosition.region(
//            MKCoordinateRegion(
//              center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
//              span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//            )
//          )
//        }
//
//        Button("Tokyo") {
//          position = MapCameraPosition.region(
//            MKCoordinateRegion(
//              center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
//              span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//            )
//          )
//        }
//      }
//    }
//  }
  
  func authenticate() {
    let context = LAContext()
    var error: NSError?
    
    // check wheter biometric authentication is possible
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      // its possible so go ahead and use it
      let reason = "We need to unlock your data."
      
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
          // authentication has now completed
        if success {
          isUnlocked = true
        } else {
          // there was a problem
        }
      }
    } else {
      // no biometrics
    }
  }
}

struct Location: Identifiable {
  let id = UUID()
  var name: String
  var coordinate: CLLocationCoordinate2D
}

// struct ContentView: View {
//  @State private var loadingState = LoadingState.loading
//
//  enum LoadingState {
//    case loading, success, failed
//  }
//
//  var body: some View {
//    switch loadingState {
//    case .loading:
//      LoadingView()
//    case .success:
//      SuccessView()
//    case .failed:
//      FailedView()
//    }
//  }
// }
//
// struct LoadingView: View {
//  var body: some View {
//    Text("Loading...")
//  }
// }
//
// struct SuccessView: View {
//  var body: some View {
//    Text("Success!")
//  }
// }
//
// struct FailedView: View {
//  var body: some View {
//    Text("Failed.")
//  }
// }

// struct ContentView: View {
//  var body: some View {
//    Button("Read and Write") {
//      let data = Data("Test Message".utf8)
//      let url = URL.documentsDirectory.appending(path: "message.txt")
//
//      do {
//        try data.write(to: url, options: [.atomic, .completeFileProtection])
//        let input = try String(contentsOf: url, encoding: .utf8)
//        print(input)
//      } catch {
//        print(error.localizedDescription)
//      }
//    }
//  }
// }

// struct ContentView: View {
//  let users: [User] = [
//    .init(firstName: "Arnorld", lastName: "Rimmer"),
//    .init(firstName: "Kristine", lastName: "Kochanski"),
//    .init(firstName: "David", lastName: "Lister"),
//  ].sorted()
//
//  var body: some View {
//    List(users) { user in
//      Text("\(user.lastName), \(user.firstName)")
//    }
//  }
// }
//
// struct User: Identifiable, Comparable {
//  let id = UUID()
//  var firstName: String
//  let lastName: String
//
//  static func < (lhs: User, rhs: User) -> Bool {
//    lhs.lastName < rhs.lastName
//  }
// }

#Preview {
  ContentView()
}

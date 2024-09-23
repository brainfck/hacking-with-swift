//
//  ContentViewViewModel.swift
//  BucketList
//
//  Created by Mykhailo Tsuber on 9/23/24.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
  @Observable
  class ViewModel {
    let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
    
    private(set) var locations: [Location]
    
    var selectedPlace: Location?
    var isUnlocked = false
    
    init() {
      do {
        let data = try Data(contentsOf: savePath)
        locations = try JSONDecoder().decode([Location].self, from: data)
      } catch {
        locations = []
      }
    }
    
    func addLocation(at point: CLLocationCoordinate2D) {
      let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: point.latitude, longitude: point.longitude)
      locations.append(newLocation)
      // temp fix for long press gesture
      selectedPlace = locations.first
      save()
    }
    
    func update(location: Location) {
      guard let selectedPlace else { return }
      
      if let index = locations.firstIndex(of: selectedPlace) {
        locations[index] = location
        save()
      }
    }
    
    func save() {
      do {
        let data = try JSONEncoder().encode(locations)
        try data.write(to: savePath, options: [.atomic, .completeFileProtection])
      } catch {
        print("Unable to save data.")
      }
    }
    
    func authenticate() {
      let context = LAContext()
      var error: NSError?
      
      if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
        let reason = "Please authenticate yourself to unlock places."
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
          if success {
            self.isUnlocked = true
          } else {}
        }
      } else {
        // no biometrics
      }
    }
  }
}

// Created by brainfck on 9/3/24.

import SwiftUI

@Observable
class Order: Codable {
  enum CodingKeys: String, CodingKey {
    case _type = "type"
    case _quantity = "quantity"
    case _specialRequestEnabled = "specialRequestEnabled"
    case _extraFrosting = "extraFrosting"
    case _addSprinkles = "addSprinkles"
    case _name = "name"
    case _city = "city"
    case _streetAddress = "streetAddress"
    case _zip = "zip"
  }
  
  static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
  
  var type = 0
  var quantity = 3
  
  var name = ""
  var streetAddress = ""
  var city = ""
  var zip = ""
  
  var specialRequestEnabled = false {
    didSet {
      if specialRequestEnabled == false {
        extraFrosting = false
        addSprinkles = false
      }
    }
  }
  var extraFrosting = false
  var addSprinkles = false
  
  var hasValidAddress: Bool {
    if name.trimmingCharacters(in: .whitespaces).isEmpty ||
        streetAddress.trimmingCharacters(in: .whitespaces).isEmpty ||
        city.trimmingCharacters(in: .whitespaces).isEmpty ||
        zip.trimmingCharacters(in: .whitespaces).isEmpty {
      return false
    }
    
    return true
  }
  
  var cost: Decimal {
    var cost = Decimal(quantity) * 2
    
    cost += Decimal(type) / 2
    
    if extraFrosting {
      cost += Decimal(quantity)
    }
    
    if addSprinkles {
      cost += Decimal(quantity) / 2
    }
    
    return cost
  }
  
  func saveOrder() {
    let encoder = JSONEncoder()
    if let encodedOrder = try? encoder.encode(self) {
      UserDefaults.standard.set(encodedOrder, forKey: "savedOrder")
    }
  }
  
  convenience init(fromUserDefaults: Bool) {
    if fromUserDefaults {
      let decoder = JSONDecoder()
      
      if let savedOrderData = UserDefaults.standard.data(forKey: "savedOrder"),
         let decodedOrder = try? decoder.decode(Order.self, from: savedOrderData) {
        self.init()
        
        self.name = decodedOrder.name
        self.streetAddress = decodedOrder.streetAddress
        self.city = decodedOrder.city
        self.zip = decodedOrder.zip
      } else {
        self.init()
      }
    } else {
      self.init()
    }
  }
}

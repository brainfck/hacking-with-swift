// Created by brainfck on 9/3/24.

import SwiftUI

struct AddressView: View {
  @Bindable var order: Order
  @State private var navigateToCheckout = false
  
  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("Name", text: $order.name)
          TextField("Street Address", text: $order.streetAddress)
          TextField("City", text: $order.city)
          TextField("Zip", text: $order.zip)
        }
        
        Section {
          Button("Check out") {
            order.saveOrder()
            
            navigateToCheckout = true
          }
          .disabled(order.hasValidAddress == false)
        }
      }
      .navigationTitle("Delivery details")
      .navigationBarTitleDisplayMode(.inline)
      .navigationDestination(isPresented: $navigateToCheckout) {
        CheckoutView(order: order)
      }
    }
    
    
  }
}

#Preview {
  AddressView(order: Order())
}

// Created by brainfck on 9/14/24.

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI

// struct ContentView: View {
//  @State private var image: Image?
//
//  var body: some View {
//    VStack {
//      image?
//        .resizable()
//        .scaledToFit()
//
////      ContentUnavailableView("No snippets", systemImage: "swift", description: Text("You don't have any saved snippets yet"))
//
//      ContentUnavailableView {
//        Label("No Snippets", systemImage: "swift")
//      } description: {
//        Text("You don't have any saved snippets yet")
//      } actions: {
//        Button("Create snippet") {}
//          .buttonStyle(.borderedProminent)
//      }
//    }
//    .onAppear(perform: loadImage)
//  }
//
//  func loadImage() {
//    let inputImage = UIImage(resource: .example)
//    let beginImage = CIImage(image: inputImage)
//
//    let context = CIContext()
//    let currentFilter = CIFilter.twirlDistortion()
//
//    currentFilter.inputImage = beginImage
//    let amount = 1.0
//
//    let inputKeys = currentFilter.inputKeys
//    if inputKeys.contains(kCIInputIntensityKey) {
//      currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
//    }
//    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
//    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
//
//
//    // get a CIImage from our filter or exit if that fails
//    guard let outputImage = currentFilter.outputImage else { return }
//
//    // attempt to get a CGImage from our CIImage
//    guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
//
//    // convert that to a UIImage
//    let uiImage = UIImage(cgImage: cgImage)
//
//    // and convert that to a SwiftUI image
//    image = Image(uiImage: uiImage)
//  }
// }

struct ContentView: View {
  @State private var pickerItem: PhotosPickerItem?
  @State private var pickerItems = [PhotosPickerItem]()
  @State private var selectedImage: Image?
  @State private var selectedImages = [Image]()

  var body: some View {
    VStack {
      PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .any(of: [.images, .not(.screenshots)])) {
        Label("Select a picture", systemImage: "photo")
      }

      ScrollView {
        ForEach(0 ..< selectedImages.count, id: \.self) { i in
          selectedImages[i]
            .resizable()
            .scaledToFit()
        }
      }

      selectedImage?
        .resizable()
        .scaledToFit()
    }
    .onChange(of: pickerItem) {
      Task {
        selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
      }
    }
    .onChange(of: pickerItems) {
      Task {
        selectedImages.removeAll()
        
        for item in pickerItems {
          if let loadedImage = try await item.loadTransferable(type: Image.self) {
            selectedImages.append(loadedImage)
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}

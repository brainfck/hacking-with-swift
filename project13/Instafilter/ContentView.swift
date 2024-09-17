// Created by brainfck on 9/14/24.

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
  @State private var processedImage: Image?
  @State private var filterIntensity = 0.5
  @State private var selectedItem: PhotosPickerItem?
  @State private var currentFilter: CIFilter = .sepiaTone()
  @State private var showingFilters = false
  
  @State private var beginImage: CIImage?
  
  let context = CIContext()
  
  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
        
        PhotosPicker(selection: $selectedItem) {
          if let processedImage {
            processedImage
              .resizable()
              .scaledToFit()
          } else {
            ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
          }
        }
        .onChange(of: selectedItem, loadImage)
        
        Spacer()
        
        HStack {
          Text("Intensity")
          Slider(value: $filterIntensity)
            .onChange(of: filterIntensity, applyProcessing)
        }
        .padding(.vertical)
        
        HStack {
          Button("Change filter", action: changeFilter)
          Spacer()
        }
        .disabled(beginImage == nil)
      }
      .padding([.horizontal, .bottom])
      .navigationTitle("Instafilter")
      .confirmationDialog("Select filter", isPresented: $showingFilters) {
        Button("Crystallize") { setFilter(CIFilter.crystallize()) }
        Button("Edges") { setFilter(CIFilter.edges()) }
        Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
        Button("Pixellate") { setFilter(CIFilter.pixellate()) }
        Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
        Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
        Button("Vignette") { setFilter(CIFilter.vignette()) }
        Button("Cancel", role: .cancel) {}
      }
    }
  }
  
  func changeFilter() {
    showingFilters = true
  }
  
  func loadImage() {
    Task {
      guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
      guard let inputImage = UIImage(data: imageData) else { return }
        
      beginImage = CIImage(image: inputImage)
      applyProcessing()
    }
  }
  
  func applyProcessing() {
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    
    let inputKeys = currentFilter.inputKeys
    
    if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
    
    guard let outputImage = currentFilter.outputImage else { return }
    guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
    
    let uiImage = UIImage(cgImage: cgImage)
    processedImage = Image(uiImage: uiImage)
  }
  
  func setFilter(_ filter: CIFilter) {
    currentFilter = filter
    applyProcessing()
  }
}

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

// struct ContentView: View {
//  @State private var pickerItem: PhotosPickerItem?
//  @State private var pickerItems = [PhotosPickerItem]()
//  @State private var selectedImage: Image?
//  @State private var selectedImages = [Image]()
//  @Environment(\.requestReview) var requestReview
//
//  var body: some View {
//    VStack {
//      PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .any(of: [.images, .not(.screenshots)])) {
//        Label("Select a picture", systemImage: "photo")
//      }
//
//      ScrollView {
//        ForEach(0 ..< selectedImages.count, id: \.self) { i in
//          selectedImages[i]
//            .resizable()
//            .scaledToFit()
//        }
//      }
//
//      ShareLink(item: URL(string: "https://www.hackingwithswift.com")!, subject: Text("Learn Swift Here"), message: Text("Check out the 100 days of SwiftUI"))
//
//      let example = Image(.example)
//
//      ShareLink(item: example, preview: SharePreview("Singapore Airport", image: example)) {
//        Label("Click to Share", systemImage: "airplane")
//      }
//
//      Button("Leave a review") {
//        requestReview()
//      }
//
//      selectedImage?
//        .resizable()
//        .scaledToFit()
//    }
//    .onChange(of: pickerItem) {
//      Task {
//        selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
//      }
//    }
//    .onChange(of: pickerItems) {
//      Task {
//        selectedImages.removeAll()
//
//        for item in pickerItems {
//          if let loadedImage = try await item.loadTransferable(type: Image.self) {
//            selectedImages.append(loadedImage)
//          }
//        }
//      }
//    }
//  }
// }

#Preview {
  ContentView()
}

//
//  ContentView.swift
//  Instafilter
//
//  Created by Max Shu on 13.08.2022.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
// 2. Experiment with having more than one slider, to control each of the input keys you care about
    @State private var filterIntensityTwo = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    //adding a saving option of images
    @State private var processedImage: UIImage?
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showingFilterSheet = false
    
// 1. buttons are unactive untill photo selected
    var allDataSet: Bool {
        if image == nil {
            return false
        }
        return true
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of: filterIntensity) { _ in applyProcessing()}
                }
                
// 2. Experiment with having more than one slider, to control each of the input keys you care about
                HStack {
                    Text("Radius")
                    Slider(value: $filterIntensityTwo)
                        .onChange(of: filterIntensityTwo) { _ in applyProcessingTwo()}
                }
                
                HStack {
                    Button("Change filter") {
                        showingFilterSheet = true
                    }
                    
                    Spacer()
                    
                    Button("Save", action: save)
                }
// 1. buttons are unactive untill photo selected
                    .disabled(allDataSet == false)
                
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("Select a filter", isPresented: $showingFilterSheet) {
                Button("Crystallize") { setFilter(CIFilter.crystallize())}
               // Button("Edges") { setFilter(CIFilter.edges())}
                Button("Box Blur") { setFilter(CIFilter.boxBlur())}
                Button("Pixellate") { setFilter(CIFilter.pixellate())}
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone())}
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask())}
                Button("Vignette") { setFilter(CIFilter.vignette())}
// 3. Explore the range of available Core Image filters, and add any three of your choosing to the app.
                Button("Circular Wrap") { setFilter(CIFilter.circularWrap())}
                Button("Noise Reduction") { setFilter(CIFilter.noiseReduction())}
                Button("Halftone") { setFilter(CIFilter.cmykHalftone())}
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
        applyProcessingTwo()
    }
    
// Saving Images
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.succesHandler = {
            print("Succes!")
        }
        
        imageSaver.errorHandler = {
            print("Ooops! \($0.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            //make the image
            let uiImage = UIImage(cgImage: cgimg)
            //stash the SwiftUI image
            image = Image(uiImage: uiImage)
            //store image in processedImage (saving)
            processedImage = uiImage
        }
    }
    
// 2. Experiment with having more than one slider, to control each of the input keys you care about
    func applyProcessingTwo() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensityTwo * 300, forKey: kCIInputRadiusKey) }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
// make the image
            let uiImage = UIImage(cgImage: cgimg)
// stash the SwiftUI image
            image = Image(uiImage: uiImage)
// store image in processedImage (saving)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

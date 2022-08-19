//
//  ContentView.swift
//  BucketList
//
//  Created by Max Shu on 16.08.2022.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
        ZStack {
            Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
// updated a pin image
                        Image(systemName: "mappin")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.red)
                            .frame(width: 35, height: 35)
                        
                        Text(location.name)
                            .fixedSize()
                    }
                    .onTapGesture {
                        viewModel.selectedPlace = location
                    }
                }
            }
                .ignoresSafeArea()
            
                Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                
                HStack {
                    
                    Button {
                        viewModel.addLocation()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .padding()
                    .background(.black.opacity(0.60))
                    .foregroundColor(.green)
                    .font(.title)
                    .clipShape(Circle())
                    .padding([.bottom], 25)
                    
                }
            }
        }
        .sheet(item: $viewModel.selectedPlace) { place in
            EditView(location: place) { newLocation in
                viewModel.update(location: newLocation)
                }
            }
        } else {
            Button("Unlock Places") {
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

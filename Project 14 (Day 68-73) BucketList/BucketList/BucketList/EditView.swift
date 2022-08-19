//
//  EditView.swift
//  BucketList
//
//  Created by Max Shu on 17.08.2022.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    
    @StateObject var editView: ViewEditModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $editView.name)
                    TextField("Description", text: $editView.description)
                }
                
                Section("Nearby") {
                    switch editView.loadingState {
                    case .loading:
                        Text("Loading")
                    case .loaded:
                        ForEach(editView.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ")
                            + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    onSave(editView.updateLocation())
                    dismiss()
                }
            }
            .task {
                await editView.fetchNearbyPlaces()
            }
        }
    }
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self.onSave = onSave
        //self.location = location
        
        _editView = StateObject(wrappedValue: ViewEditModel(location: location))
        
        //_name = State(initialValue: location.name)
        //_description = State(initialValue: location.description)
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in }
    }
}

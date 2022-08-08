//
//  DetailView.swift
//  Bookworm
//
//  Created by Max Shu on 07.08.2022.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No Review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)

// 3. Add a new “date” attribute to the Book entity
            Text("Review added: \(Date.now, format: .dateTime.day().month().year())")
                .foregroundColor(.gray)
                .padding()
                .lineSpacing(30)
                .multilineTextAlignment(.leading)
            
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    let date = Calendar.current.date(from: components) ?? Date.now
    let components = Calendar.current.dateComponents([day, month, year], from: someDate)
    let day = components.day ?? 0
    let month = components.month ?? 0
    let year = components.year ?? 0
    
    func deleteBook() {
        moc.delete(book)
        
        // try? moc.save()
        dismiss()
    }
}


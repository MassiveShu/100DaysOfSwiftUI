//
//  DetailView.swift
//  MyFriendsList
//
//  Created by Max Shu on 11.08.2022.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        List {
            Section {
                Text(user.about)
                    .padding()
            } header: {
                Text("About")
            }
            
            Section {
                Text("Address: \(user.address)")
                Text("Company: \(user.company)")
                Text("Email: \(user.email)")
            } header: {
                Text("Contact details")
            }
            
            Section {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            } header: {
                Text("Friends")
            }
        }
        .listStyle(.grouped)
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: User.example)
    }
}

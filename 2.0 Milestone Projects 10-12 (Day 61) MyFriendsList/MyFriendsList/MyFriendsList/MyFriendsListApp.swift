//
//  MyFriendsListApp.swift
//  MyFriendsList
//
//  Created by Max Shu on 11.08.2022.
//

import SwiftUI

@main
struct MyFriendsListApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

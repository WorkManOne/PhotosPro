//
//  PhotosProApp.swift
//  PhotosPro
//
//  Created by Кирилл Архипов on 14.10.2025.
//

import SwiftUI

@main
struct PhotosProApp: App {
    @ObservedObject var userService = UserService()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userService)
                .preferredColorScheme(.dark)
        }
    }
}

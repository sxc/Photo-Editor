//
//  Photo_EditorApp.swift
//  Photo Editor
//
//  Created by Xiaochun Shen on 2020/9/27.
//

import SwiftUI

@main
struct Photo_EditorApp: App {
    
    @StateObject var imageController = ImageController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(imageController)
        }
    }
}

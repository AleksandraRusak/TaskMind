//
//  TaskMindApp.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-01.
//

import SwiftUI
import FirebaseCore

@main
struct TaskMindApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

//
//  oppenAppSettings.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-14.
//

import SwiftUI
import Foundation

func openAppSettings() {
    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
        return
    }
    
    if UIApplication.shared.canOpenURL(settingsUrl) {
        UIApplication.shared.open(settingsUrl, completionHandler: { success in
            print("Settings opened: \(success)") // Prints true if the settings opened successfully
        })
    }
}

//
//  ContentViewViewModel.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-02.
//

import Foundation
import FirebaseAuth

class ContentViewViewModel: ObservableObject {
    
    @Published var currentUserId: String = ""
    
    // This listener will be called whenever the auth state changes (a user signs in or out)
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}

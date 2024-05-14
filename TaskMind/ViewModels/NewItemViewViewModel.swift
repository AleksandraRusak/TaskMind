//
//  NewItemViewViewModel.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-02.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class NewItemViewViewModel: ObservableObject {
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    @Published var isNotificationScheduled = false

    
    var id: String? // Identifier for existing items
    
    init() {}
    
    func save() {
        guard onSave else {
            return
        }
        
        // get current user id
        guard let uId = Auth.auth().currentUser?.uid else {
            return
        }
        
        // create model
        let myNotification = MyLocalNotification()
        let newId = id ?? UUID().uuidString
        let newTask = ToDoListItem(
            id: newId,
            title: title,
            dueDate: dueDate.timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false)
        
        
        // save to Firebase
        let db = Firestore.firestore()
        db.collection("users")
            .document(uId)
            .collection("todos")
            .document(newId)
            .setData(newTask.asDictionary()) { error in
                if let error = error {
                    print("Error saving to Firestore: \(error.localizedDescription)")
                } else {
                    // Schedule local notification
                    myNotification.scheduleLocalNotification(for: newTask)
                }
            }
    }
    
    var onSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        // 86400 = seconds in 24 hours
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
    
    func reset() {
            id = nil
            title = ""
            dueDate = Date()
        }
}

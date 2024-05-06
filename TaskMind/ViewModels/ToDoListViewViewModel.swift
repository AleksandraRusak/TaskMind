//
//  ToDoListViewViewModel.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-02.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

// ViewModel for list of all todos
class ToDoListViewViewModel: ObservableObject {
    
    @Published var showingNewItemView = false
    
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    // Delete to do list item
    func delete(id: String) {
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
    
    func toggleIsDone(item: ToDoListItem) {
            var itemCopy = item
            itemCopy.isDone.toggle()
            
            let db = Firestore.firestore()
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            
            db.collection("users")
                .document(uid)
                .collection("todos")
                .document(itemCopy.id)
                .setData(itemCopy.asDictionary())
        }
}

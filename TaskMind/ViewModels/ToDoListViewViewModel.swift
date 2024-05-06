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


//import Foundation
//import FirebaseFirestore
//import FirebaseAuth
//
//class ToDoListViewViewModel: ObservableObject {
//    @Published var items: [ToDoListItem] = []  // This needs to be fetched appropriately
//    @Published var showingNewItemView = false
//
//    private let userId: String
//    private var db = Firestore.firestore()
//
//    init(userId: String) {
//        self.userId = userId
//        fetchItems()
//    }
//
//    func fetchItems() {
//        db.collection("users").document(userId).collection("todos")
//            .whereField("isDone", isEqualTo: false)  // Only fetch incomplete items
//            .addSnapshotListener { querySnapshot, error in
//                if let querySnapshot = querySnapshot {
//                    self.items = querySnapshot.documents.compactMap { document in
//                        try? document.data(as: ToDoListItem.self)
//                    }
//                }
//            }
//    }
//
//    func toggleIsDone(item: ToDoListItem) {
//        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
//
//        // Optimistically update the UI
//        items[index].isDone = true
//
//        // Delay the Firestore update
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.updateItemInFirestore(item: self.items[index])
//            self.items.remove(at: index)  // Remove from the local array after 2 seconds
//        }
//    }
//
//    private func updateItemInFirestore(item: ToDoListItem) {
//        db.collection("users").document(userId).collection("todos")
//            .document(item.id)
//            .updateData(["isDone": true])  // Set isDone to true in Firestore
//    }
//
//    func delete(id: String) {
//        db.collection("users").document(userId).collection("todos")
//            .document(id).delete()
//    }
//}

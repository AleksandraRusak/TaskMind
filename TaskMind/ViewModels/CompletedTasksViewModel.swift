//
//  CompletedTasksViewModel.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-06.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class CompletedTasksViewModel: ObservableObject {
    @Published var completedItems: [ToDoListItem] = []

    private let userId: String
    private var db = Firestore.firestore()

    init(userId: String) {
        self.userId = userId
        fetchCompletedItems()
    }

    func fetchCompletedItems() {
        db.collection("users").document(userId).collection("todos")
            .whereField("isDone", isEqualTo: true)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting completed tasks: \(error)")
                    return
                }
                
                self.completedItems = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: ToDoListItem.self)
                } ?? []
            }
    }

    func delete(item: ToDoListItem) {
        // Directly use item.id as it is non-optional
        db.collection("users").document(userId).collection("todos").document(item.id).delete { error in
            if let error = error {
                print("Error deleting task: \(error)")
                return
            }
            // Optionally remove the item from the local array
        }
    }


    func filteredCompletedItems(searchText: String) -> [ToDoListItem] {
        if searchText.isEmpty {
            return completedItems
        } else {
            return completedItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

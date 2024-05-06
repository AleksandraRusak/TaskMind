//
//  ToDoListItem.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-02.
//

import Foundation

struct ToDoListItem: Codable, Identifiable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    
    // method to update a completion status
    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}

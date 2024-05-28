//
//  CompletedView.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-06.
//

import SwiftUI
import FirebaseFirestoreSwift

struct CompletedView: View {
    @StateObject var viewModel: CompletedTasksViewModel
    @State private var searchText = ""
    @State private var showDeleteAlert = false

    init(userId: String) {
        _viewModel = StateObject(wrappedValue: CompletedTasksViewModel(userId: userId))
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.filteredCompletedItems(searchText: searchText)) { item in
                    ToDoListItemView(item: item, toggleIsDone: {
                        // This could be empty or modify to un-complete the task
                    })
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.delete(item: item)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Completed Tasks")
            .searchable(text: $searchText)
            .toolbar {
                            Button {
                                showDeleteAlert = true
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(Color.red)
                            }
                        }
                        .alert("Are you sure you want to delete all completed tasks?", isPresented: $showDeleteAlert) {
                            Button("Delete", role: .destructive) {
                                viewModel.deleteAllCompletedTasks()
                            }
                            Button("Cancel", role: .cancel) { }
                        } message: {
                            Text("This action cannot be undone.")
                        }

        }
    }
}

struct CompletedView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedView(userId: "testUserID")
    }
}

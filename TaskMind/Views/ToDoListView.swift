//
//  ToDoListView.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-02.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]
    @State private var searchText = ""
    
    @State private var editingItem: ToDoListItem? // For editing existing items
    
    
    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        self._viewModel = StateObject(wrappedValue: ToDoListViewViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredItems) { item in
                    ToDoListItemView(item: item, toggleIsDone: {
                        viewModel.toggleIsDone(item: item)
                    })
                    
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.delete(id: item.id)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    
                    .swipeActions(edge: .leading) {
                        Button {
                            editingItem = item
                            viewModel.showingNewItemView = true
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.blue)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("To Do List")
            .searchable(text: $searchText) // Using the searchable modifier
            .overlay {
                            if filteredItems.isEmpty && searchText.isEmpty {
                                Text("No Tasks Yet")
                            } else if filteredItems.isEmpty {
                                ContentUnavailableView.search
                            }
            }
            .toolbar {
                Button {
                    editingItem = nil // Reset for adding new item
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color.myBlue)
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView, content: {
                NewItemView(newItemPresented: $viewModel.showingNewItemView, itemToEdit: editingItem)
            })
        }
    }
    
    private var filteredItems: [ToDoListItem] {
           if searchText.isEmpty {
               return viewModel.items.sorted(by: { $0.dueDate > $1.dueDate })
           } else {
               return viewModel.items.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
                           .sorted(by: { $0.dueDate > $1.dueDate })
           }
       }
   }
    
    struct ToDoListView_Previews: PreviewProvider {
        static var previews: some View {
            ToDoListView(userId: "ICm3vTb0VEX3P5rgioEWy3nhJNm1")
        }
    }


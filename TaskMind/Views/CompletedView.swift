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
        }
    }
}

struct CompletedView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedView(userId: "testUserID")
    }
}

//import SwiftUI
//import FirebaseFirestoreSwift
//import FirebaseAuth
//
//struct CompletedView: View {
//    @StateObject var viewModel: CompletedTasksViewModel
//    @State private var searchText = ""
//
//    init(userId: String) {
//        _viewModel = StateObject(wrappedValue: CompletedTasksViewModel(userId: userId))
//    }
//
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(filteredItems, id: \.id) { item in
//                    HStack {
//                        Text(item.title)
//                        Spacer()
//                        Text("\(Date(timeIntervalSince1970: item.dueDate), style: .date)")
//                        Image(systemName: "checkmark.circle.fill")
//                            .foregroundColor(.myBlue)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .listStyle(PlainListStyle())
//            .navigationTitle("Completed Tasks")
//            .searchable(text: $searchText)
//        }
//    }
//
//    private var filteredItems: [ToDoListItem] {
//        if searchText.isEmpty {
//            return viewModel.completedItems
//        } else {
//            return viewModel.completedItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
//        }
//    }
//
//    private func deleteItems(at offsets: IndexSet) {
//        offsets.forEach { index in
//            viewModel.delete(item: filteredItems[index])
//        }
//    }
//}
//
//struct CompletedView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompletedView(userId: "testUserID")
//    }
//}

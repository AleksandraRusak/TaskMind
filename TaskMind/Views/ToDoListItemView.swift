//
//  ToDoListItemView.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-02.
//

import SwiftUI

struct ToDoListItemView: View {
    
    @StateObject var viewModel = ToDoListItemViewViewModel()
    
    let item: ToDoListItem
    var toggleIsDone: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.body)
                    Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                        .font(.footnote)
                        .foregroundColor(dueDateColor)
                }
                Spacer()
                
                Button {
                    toggleIsDone()
                } label: {
                    Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(.myBlue)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
    
    private var dueDateColor: Color {
           let currentDate = Date()
           let dueDate = Date(timeIntervalSince1970: item.dueDate)

           if currentDate > dueDate && !item.isDone {
               return .red // Past due date and not done
           } else {
               return .secondary // Default color
           }
       }
}

struct ToDoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListItemView(item: .init(
            id: "123",
            title: "Read book",
            dueDate: Date().timeIntervalSince1970,
            createdDate: Date().timeIntervalSince1970,
            isDone: false),
            toggleIsDone: { }
        )
    }
}

//
//  ToListButton.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-02.
//

import SwiftUI

extension Color {
    static let customBlue = Color(red: 13 / 255, green: 134 / 255, blue: 143 / 255)
}
struct ToListButton: View {
    
    let title: String
    let action: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            Button {
                action()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.customBlue)
                    
                    Text(title)
                        .foregroundColor(.white)
                        .bold()
                }
                .frame(height: 35)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
            

    struct  ToListButton_Previews: PreviewProvider {
                   static var previews: some View {
                       ToListButton(title: "Value") {
                       }
                   }
               }
   


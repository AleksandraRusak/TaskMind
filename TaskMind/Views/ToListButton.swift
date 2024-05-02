//
//  ToListButton.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-02.
//

import SwiftUI

struct ToListButton: View {
    
    let title: String
    let action: () -> Void
    var buttonColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            Button {
                action()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(buttonColor)
                        
                    
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
                       ToListButton(title: "Value",
                                    action: {},
                                    buttonColor: .blue)
                       }
                   }
               
   


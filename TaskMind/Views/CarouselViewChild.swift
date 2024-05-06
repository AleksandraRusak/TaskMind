//
//  CarouselViewChild.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-06.
//

import SwiftUI

struct CarouselViewChild: View, Identifiable {
    var id: Int
    @ViewBuilder var content: any View
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
    }
}

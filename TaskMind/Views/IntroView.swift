//
//  IntroView.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-06.
//

import SwiftUI

struct IntroView: View {
    @State private var showLogin = false  // State to control the view transition

    var body: some View {
        ZStack {
            CarouselView(views: getChildViews())

            VStack {
                Spacer()  // Pushes the button to the bottom
                Button("Next") {
                    showLogin = true  // Set the state to change the view
                }
                .padding()
                .background(Color.myBlue)  
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.bottom, 30)
            }
            // Using conditional view rendering based on state
            if showLogin {
                LoginView()
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)  // Maximize to available space
    }
    
    func getChildViews() -> [CarouselViewChild] {
        var tempViews: [CarouselViewChild] = []
        
        for i in 1...3 {
            tempViews.append(CarouselViewChild(id: i, content: {
                ZStack {
                    Image("\(i)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: 250, height: 400)
                .shadow(radius: 5)
            }))
        }
        return tempViews
    }
}



// Preview to see how it looks in the SwiftUI Preview
struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}

//
//  IntroView.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-06.
//



import SwiftUI

struct IntroView: View {
    @Binding var showLogin: Bool

    var body: some View {
        ZStack {
            CarouselView(views: getChildViews())
            VStack {
                Spacer()
                Button("Next") {
                    showLogin = false
                }
                .padding()
                .background(Color.myBlue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.bottom, 30)
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView(showLogin: .constant(true))
    }
}




//import SwiftUI
//
//struct IntroView: View {
//    @State private var showLogin = false
//
//    var body: some View {
//        ZStack {
//            CarouselView(views: getChildViews())
//
//            VStack {
//                Spacer()
//                Button("Next") {
//                    showLogin = true
//                }
//                .padding()
//                .background(Color.myBlue)  
//                .foregroundColor(.white)
//                .cornerRadius(10)
//                .padding(.bottom, 30)
//            }
//            
//            if showLogin {
//                LoginView()
//            }
//        }
//        .ignoresSafeArea()
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//    
//    func getChildViews() -> [CarouselViewChild] {
//        var tempViews: [CarouselViewChild] = []
//        
//        for i in 1...3 {
//            tempViews.append(CarouselViewChild(id: i, content: {
//                ZStack {
//                    Image("\(i)")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                }
//                .frame(width: 250, height: 400)
//                .shadow(radius: 5)
//            }))
//        }
//        return tempViews
//    }
//}
//
//
//
//struct IntroView_Previews: PreviewProvider {
//    static var previews: some View {
//        IntroView()
//    }
//}

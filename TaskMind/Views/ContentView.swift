//
//  ContentView.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-01.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewViewModel()

    @State var hideSplash = false
    @State private var showIntro = true  // Controls the display of IntroView
    @State private var showLoginView = false
    
    
    let title = "TaskMinder"
    private var initialDelays = [0.0, 0.018, 0.32, 0.35]
   

    var body: some View {
        GeometryReader { geometry in
            VStack {
                if !hideSplash {
                    splashScreen
                } else {
                    if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
                        mainTabView
                    } else {
                        if showIntro {
                            IntroView(showLogin: $showIntro)
                        } else {
                            LoginView()
                        }
                    }
                }
            }.frame(width: geometry.size.width, height: geometry.size.height) 
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                withAnimation {
                    hideSplash = true
                }
            }
        }
    }

    var splashScreen: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                            ZStack {
                                AnimatedTitleView(title: title, color: .C_3, initialDelay: initialDelays[3], animationType: .spring(duration: 1))
                                AnimatedTitleView(title: title, color: .C_2, initialDelay: initialDelays[2], animationType: .spring(duration: 1))
                                AnimatedTitleView(title: title, color: .C_1, initialDelay: initialDelays[1], animationType: .spring(duration: 1))
                                AnimatedTitleView(title: title, color: .C_1, initialDelay: initialDelays[1], animationType: .spring)
                            }
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 230, height: 230)
            }
        }
    }

    @ViewBuilder
    var mainTabView: some View {
        TabView {
            ToDoListView(userId: viewModel.currentUserId)
                .tabItem{
                    Label("Home", systemImage: "house")
                }
            CompletedView(userId: viewModel.currentUserId)
                .tabItem{
                    Label("History", systemImage: "checklist.checked")
                }
            ProfileView()
                .tabItem{
                    Label("Profile", systemImage: "person.circle")
                }
        }.accentColor(.myBlue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct AnimatedTitleView: View {
    let title: String
    let color: Color
    let initialDelay: Double
    let animationType: Animation
    @State var scall = false
    @State private var show = false
    private var delayStep = 0.1
    init(title: String, color: Color, initialDelay: Double, animationType: Animation) {
        self.title = title
        self.color = color
        self.initialDelay = initialDelay
        self.animationType = animationType
    }
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<title.count, id: \.self) { index in
                Text(String(title[title.index(title.startIndex, offsetBy: index)]))
                    .font (.system(size: 60)) .bold()
                    .opacity(show ? 1 : 0)
                    .offset (y: show ? -30 : 30)
                    .animation(animationType.delay(Double(index) * delayStep + initialDelay), value: show)
                    .foregroundStyle (color)
            }
        }
        .scaleEffect(scall ? 1.1 : 1)
        .onAppear(){
        show.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                scall.toggle()
            }
        }
    }
}
}



// rus@gmail.com


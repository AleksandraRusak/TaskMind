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
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if !hideSplash {
                    ZStack {
                        Color.white.edgesIgnoringSafeArea(.all)
                        VStack {
                            Text("TaskMind")
                                .font(.system(size: 60))
                                .fontWeight(.bold)
                                .foregroundColor(Color.myBlue)
                                .padding(.bottom, 50)
                            
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 230, height: 230)
                            
                        }
                    }
                } else {
                    
                if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
                    
                    TabView {
                        ToDoListView(userId: viewModel.currentUserId)
                            .tabItem{
                                Label("Home", systemImage: "house")
                            }
                        CompletedView()
                            .tabItem{
                                Label("History", systemImage: "checklist.checked")
                            }
                        ProfileView()
                            .tabItem{
                                Label("Profile", systemImage: "person.circle")
                            }
                    }.accentColor(.myBlue)
                } else {
                    LoginView()
                }
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
            
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    hideSplash = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

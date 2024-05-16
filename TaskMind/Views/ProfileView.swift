//
//  ProfileView.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-02.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewViewModel()
    
    @State private var presentImagePicker = false
    @State private var presentActionScheet = false
    @State private var presentCamera = false
    @State private var showDeleteAlert = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    @Binding var showLoginView: Bool

    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
//                extra button to Logout
//                TODO - fix delete account
//                TODO - settings to allow notifications
                Button("Log out", action: {
                viewModel.logOut()
            })
                
                
                VStack {
                    if let user = viewModel.user {
                        Group {
                                if let imageURL = viewModel.imageURL {
                                    AsyncImage(url: imageURL) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image.resizable()
                                                 .aspectRatio(contentMode: .fill)
                                                 .frame(width: 180, height: 180)
                                                 .clipShape(Circle())
                                        case .failure(_):
                                            Image(systemName: "person.circle.fill")
                                                 .resizable()
                                                 .aspectRatio(contentMode: .fill)
                                                 .frame(width: 180, height: 180)
                                                 .clipShape(Circle())
                                        case .empty:
                                            ProgressView()
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                } else {
                                   Image(systemName: "person.circle")
                                    .resizable()
                                }
                            }
                                .foregroundColor(.myBlue)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 180, height: 180)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                .shadow(radius: 10)
                                .padding()
                                .onTapGesture { self.presentActionScheet = true }
                                .sheet(isPresented: $presentImagePicker) {
                                    
                                    
                                    ImagePickerView(sourceType: presentCamera ? .camera : .photoLibrary, image: self.$viewModel.image, isPresented: self.$presentImagePicker, viewModel: viewModel)
                                    
                                    
                                }.actionSheet(isPresented: $presentActionScheet) { () -> ActionSheet in
                                    ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                                        presentImagePicker = true
                                        presentCamera = true
                                    }), ActionSheet.Button.default(Text("Photo Library"), action: {
                                        presentImagePicker = true
                                        presentCamera = false
                                    }), ActionSheet.Button.default(Text("Random Photo"), action: {
                                        viewModel.fetchImageWithCompletion()
                                    }),ActionSheet.Button.cancel()])
                                }
                            // users info: name, email, member since
                        Form {
                                Section(header: Text("Personal Information")) {
                                                Text("Name: \(user.name)")
                                                Text("Email: \(user.email)")
                                                Text("Member since: \(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                                                }

                                Section {
                                        Button("Log out", action: {
                                        viewModel.logOut()
                                    })
                                    .tint(.red)
                                    }
                            
                            Section(header: Text("Settings")) {
                                Button("Allow Notifications") {
                                    openAppSettings()
                                                                }
                                                Link("Privacy Policy", destination: URL(string: "https://www.freeprivacypolicy.com/live/5bb1a717-6917-4a08-a205-fd905ab23b06")!)
                                                Link("Terms & Conditions", destination: URL(string: "https://www.freeprivacypolicy.com/live/45d9597b-7392-421a-a9cb-0a7e1444914a")!)
                                            }
                            Section {
                                Button("Delete account") {
                                    showDeleteAlert = true
                                                                }
                                                                .tint(.red)
                                                                .alert("Are you sure you want to delete your account?", isPresented: $showDeleteAlert) {
                                                                    Button("Delete", role: .destructive) {
                                                                        Task {
                                                                            do {
                                                                                try await viewModel.delete()
                                                                                showLoginView = true
                                                                            }
                                                                                        catch {
                                                                                            errorMessage = error.localizedDescription
                                                                                                                                            showErrorAlert = true
                                                                                                    }
                                                                                                }
                                                                    }
                                                                    Button("Cancel", role: .cancel) { }
                                                                } message: {
                                                                    Text("This action cannot be undone.")
                                                                }
                                                                .alert("Error", isPresented: $showErrorAlert) {
                                                                                                    Button("OK", role: .cancel) { }
                                                                                                } message: {
                                                                                                    Text(errorMessage)
                                                                                                }
                                                            }
                                                        }
                          
                        } 
                    else {
                            Text("Loading Profile...")
                        }
                        
                    }.navigationTitle("Profile")
                
             }.onAppear {
                 viewModel.fetchUser()
             }.frame(width: geometry.size.width, height: geometry.size.height)
           }
        }
}

struct ProfileView_Previews: PreviewProvider {
    @State static var showLoginView = false  // Create a mock state

    static var previews: some View {
        ProfileView(showLoginView: $showLoginView)  // Pass the binding
    }
}


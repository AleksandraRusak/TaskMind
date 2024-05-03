//
//  LoginView.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-02.
//

import SwiftUI

extension Color {
    static let myBlue = Color(red: 13 / 255, green: 134 / 255, blue: 143 / 255)
}

struct LoginView: View {
 @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        GeometryReader { geometry in
        NavigationStack{
                VStack {
                    // Header
                    ZStack {
                        Image("login")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack {
                            Text("Welcome")
                                .font(.system(size: 50))
                                .foregroundColor(Color.white)
                                .bold()
                            
                            Text("Back!")
                                .font(.system(size: 50))
                                .foregroundColor(Color.white)
                                .bold()
                        }
                        .padding(.top, -120)
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height / 2.5)
                    
                    
                    // Form
                    Form {
                        
                        if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                        }
                        
                        TextField("Email address", text: $viewModel.email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .padding(.top, 5)
                            .listRowSeparator(.hidden)
                        SecureField("Password", text: $viewModel.password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.top, 5)
                            .listRowSeparator(.hidden)
                        
                        ToListButton(title: "Log in", action: {
                                                    viewModel.login()
                                                }, buttonColor: Color.myBlue)
                                                .padding(.top, 15)
                                                .padding(.bottom, 25)
                    }.scrollContentBackground(.hidden)
                    
              
                    
                    
                    // Create Account
                    VStack {
                        Text("New around here?")
                        NavigationLink("Create an account", destination: SignupView())
                            .foregroundColor(Color.myBlue)
                    }
                    
                    .padding(.bottom, 30)
                    
                    Spacer()
                }
            }
        .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}



struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

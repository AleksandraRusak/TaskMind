//
//  SignupView.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-02.
//


import SwiftUI

extension Color {
    static let myGreen = Color(red: 89 / 255, green: 184 / 255, blue: 172 / 255)
}

struct SignupView: View {
    @StateObject var viewModel = SignupViewViewModel()
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Header
                ZStack {
                    Image("signup")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)

                    VStack {
                        Text("Welcome!")
                            .font(.system(size: 50))
                            .foregroundColor(Color.white)
                            .bold()
                    }
                    .padding(.top, -100)
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 2.7)
                
                // Form
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    TextField("Full name", text: $viewModel.name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .padding(.top, 5)
                        .listRowSeparator(.hidden)
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

                    ToListButton(title: "Sign up", action: {
                                            viewModel.register()
                                        }, buttonColor: Color.myGreen)
                    .padding(.top, 15)
                    .padding(.bottom, 25)
                    }.scrollContentBackground(.hidden)
                }
            .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }


struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

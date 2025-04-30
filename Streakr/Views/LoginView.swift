//
//  LoginView.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-04-29.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginButtonDisabled = true
    @State private var showPassword = false
    @State private var showToast = false
    @State private var showSignUpSheet = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(.loginRed),
                                            Color(.loginGray)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            Spacer()
            
            VStack(spacing: 20) {
                Text("Welcome to Streakr!")
                    .font(.title.bold())
                    .foregroundStyle(Color(.black))
                
                Image("Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .clipShape(.rect(cornerRadius: 12))
                
                Text("Login to continue")
                    .font(.subheadline)
                    .foregroundStyle(Color(.loginGray))
                
                InputField(text: $email,
                           placeholder: "Email",
                           icon: "envelope.fill",
                           isSecure: false)
                .onChange(of: email, enableButton)
                
                ZStack(alignment: .trailing) {
                    InputField(text: $password,
                               placeholder: "Password",
                               icon: "lock.fill",
                               isSecure: !showPassword)
                    .onChange(of: password, enableButton)
                    
                    Button(action: {
                        showPassword.toggle()
                    }) {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .foregroundStyle(Color(.loginGray))
                            .padding()
                    }
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        
                        //TODO Återställ lösenord
                        
                    }) {
                        Text("Forgot password?")
                            .font(.footnote)
                            .foregroundStyle(Color(.blue).opacity(0.8))
                            .padding(.vertical, 6)
                            .contentShape(Rectangle())
                    }
                }
                .padding(.vertical, -10)
                
                Button(action: {
                    Task {
                        await authVM.signIn(email: email, password: password)
                        
                        if let error = authVM.errorMessage {
                            print(error)
                            showToast = true
                            
                            try? await Task.sleep(nanoseconds: 3_000_000_000)
                            showToast = false
                        }
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(isLoginButtonDisabled ?
                                    Color(.loginButtonGray) :
                                        Color(.loginButtonBlue))
                        .clipShape(.rect(cornerRadius: 12))
                        .shadow(radius: 2)
                }
                .disabled(isLoginButtonDisabled)
                .padding(.top, 10)
                
                HStack {
                    Text("No account?")
                        .font(.footnote)
                        .foregroundStyle(Color(.loginGray))
                    
                    Button(action: {
                        showSignUpSheet = true
                        
                    }) {
                        Text("Sign Up")
                            .font(.footnote.bold())
                            .underline()
                            .foregroundStyle(Color(.blue))
                    }
                    .sheet(isPresented: $showSignUpSheet) {
                        SignUpView()
                            .environmentObject(authVM)
                    }
                }
                
                
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 35)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(radius: 2)
            .padding(.horizontal, 25)
            
            Spacer()
            
        }
        .toast(isShowing: $showToast, message: authVM.errorMessage ?? "Something went wrong!")
    }
    
    private func isEmailValid(_ email: String) -> Bool {
        email.contains("@") && email.contains(".")
    }
    
    private func enableButton() {
        isLoginButtonDisabled = email.isEmpty || password.isEmpty || !isEmailValid(email)
    }
}

struct InputField: View {
    @Binding var text: String
    var placeholder: String
    var icon: String
    var isSecure: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(Color(.loginGray))
                .frame(width: 24)
            
            if isSecure {
                SecureField(placeholder, text: $text)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
            } else {
                TextField(placeholder, text: $text)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
                    .keyboardType(placeholder.contains("Email") ? .emailAddress : .default)
            }
        }
        .padding()
        .background(Color(.systemGray5))
        .clipShape(.rect(cornerRadius: 12))
        .shadow(radius: 2)
    }
}


#Preview {
    LoginView()
}

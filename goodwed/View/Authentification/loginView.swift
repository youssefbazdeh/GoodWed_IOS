//
//  loginView.swift
//  goodwed
//
//  Created by omarKaabi on 25/3/2023.
//

import SwiftUI

struct LoginView: View {
    @StateObject var loginViewModel = LoginViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isChecked = false
    @State private var loginSuccess = false
    @State private var showHomePageView = false
    @State private var showForgetPassword = false
    @State var test = UserDefaults.standard.bool(forKey: "test")


    var body: some View {
        if (test==true){
        nav()
        }else {
            ZStack {
                Color(hex: "8A47EB")
                VStack {
                    Image("login")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 275)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5411764979, blue: 0.2784313858, alpha: 0.4)),Color(#colorLiteral(red: 0.5411764979, green: 0.2784313858, blue: 0.9215686917, alpha: 1))]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    
                        .edgesIgnoringSafeArea(.all)
                    
                    Spacer()
                    
                    Text("Welcome to GoodWed")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.white)
                        .offset(x:-50,y:-100)
                    
                    Text("Enter your email and password to sign in")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .offset(x:-40,y:-100)
                    
                    Spacer()
                    VStack(spacing: 16) {
                        TextField("E-mail", text: $email)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .offset(x:0,y:-80)
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .offset(x:0,y:-80)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("Sign Up")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 16)
                            .frame(width: 290,height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 177)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                        
                            .offset(x:0,y:-400)
                    }
    
                    NavigationLink(destination: nav().navigationBarHidden(false), isActive: $test){
                        VStack{
                            Button(action: {
                                // button action here
                                print("aaaaaa")
                                self.showHomePageView=true
                            }) {
                                Text("")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 290, height: 40)
                                    .background(
                                        RoundedRectangle(cornerRadius: 177)
                                            .fill(Color.purple)
                                    )
                            }
                            .offset(x:0,y:-100)
                        }
                        
                    }
                    
                    Toggle(isOn: $isChecked){
                        Text("Remember Me")
                            .foregroundColor(.white)
                    }.toggleStyle(CheckboxToggleStyle())
                        .offset(x:-110,y: -260)
                    
                    
                        .padding(.horizontal)
                        .padding(.bottom, -10)
                }
                Text("Login")
                    .font(.system(size: 21, weight: .bold))
                    .offset(x:0,y:283)
                    .foregroundColor(.white)
                    .onTapGesture {
                        self.showHomePageView=true
                        print("aaaaaaa")
                        let request = LoginRequest(email: email, password: password)
                        print(request)
                        loginViewModel.login(request: request) { result in
                            switch result {
                            case .success(let response):
        
                                // Action si la connexion est réussie
                                print(response)
                                UserDefaults.standard.set(response.accessToken, forKey: userDefaultsKey    )                                                                   
                                self.loginSuccess = true // Set login success to true
                                //self.redirectToHomePage = true // Set redirectToHomePage to true
                            case .failure(let error):
                                // Action si la connexion échoue
                                print(error)
                            }
                        }
                    }
                if showHomePageView {
                    NavigationLink(destination: nav(), isActive: $loginSuccess) {
                        EmptyView()
                    }
                }
   
                Text("Forget Password ?")
                    .font(.system(size: 17))
                    .offset(x:0,y:330)
                    .foregroundColor(.white)
                    .onTapGesture {
                        self.showForgetPassword=true
                    }
                if showForgetPassword {
                    NavigationLink(destination: forgetPassword(), isActive: $showForgetPassword) {
                        EmptyView()
                    }
                }
                    
            }
            .ignoresSafeArea()
            
        }
    }
   
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                configuration.label
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue >> 16) & 0xFF
        let g = (rgbValue >> 8) & 0xFF
        let b = rgbValue & 0xFF
        
        self.init(
            .sRGB,
            red: Double(r) / 255.0,
            green: Double(g) / 255.0,
            blue: Double(b) / 255.0,
            opacity: 1.0
            
        )
    
    }
    
}

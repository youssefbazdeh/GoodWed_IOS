//
//  ContentView.swift
//  goodwed
//
//  Created by omarKaabi on 25/3/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showSingUpView = false
    @State private var showLoginView = false
    var body: some View {
        NavigationView{
        ZStack {
            Image("wedd")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.5411764979, blue: 0.2784313858, alpha: 0.4)),Color(#colorLiteral(red: 0.5411764979, green: 0.2784313858, blue: 0.9215686917, alpha: 1))]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            // Your other views here
            
            VStack {
                Spacer()
                Image("logo")
                
                    .resizable()
                    .offset(y: 100)
                    .frame(width: 300, height: 300)
                
                VStack{
                    Text("Login")
                        .foregroundColor(.white)
                        .offset(y: 350)
                        .font(.system(size: 20))
                        .padding(.bottom, 10)
                        .onTapGesture {
                            self.showLoginView=true
                        }
                    NavigationLink(destination: LoginView().navigationBarHidden(true), isActive: $showLoginView){}
                }

                Spacer()
                

                    
                    NavigationLink(destination: singup().navigationBarHidden(false), isActive: $showSingUpView){
                        VStack{
                            Button(action: {
                                // button action here
                                self.showSingUpView=true
                            }) {
                                Text("Sign up")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 290, height: 40)
                                    .background(
                                        RoundedRectangle(cornerRadius: 177)
                                            .fill(Color(#colorLiteral(red: 0.5411764979, green: 0.2784313858, blue: 0.9215686321, alpha: 1)))
                                    )
                            }
                        }
                    }
                
                
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "phone")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                        Text("Phone")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 290, height: 40)
                .background(Color.white.opacity(0.1))
                .cornerRadius(30)
                .padding(.top, 20)
                Button(action: {}) {
                    HStack {
                        Image("google")
                            .resizable()
                            .frame(width: 30 ,height: 30)
                            .offset(x:5)
                        Text("Google")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 290, height: 40)
                .background(Color.white.opacity(0.1))
                .cornerRadius(30)
                .padding(.top, 10)
                
                Button(action: {}) {
                    HStack {
                        Image("facebook")
                            .resizable()
                            .frame(width: 30 ,height: 30)
                            .offset(x:0)
                        
                        Text("Facebook")
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 290, height: 40)
                .background(Color.white.opacity(0.1))
                .cornerRadius(30)
                .padding(.top, 10)
                Spacer()
            }
            .padding(.horizontal, 52)
        }

    }
        .navigationBarBackButtonHidden(true)

    }
}

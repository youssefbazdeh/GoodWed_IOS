//
//  forgetPassword.swift
//  goodwed
//
//  Created by omarKaabi on 7/4/2023.
//

import SwiftUI

struct forgetPassword:View {
    @StateObject var signupViewModel=SignupViewModel()

    @State private var email: String = ""
   

    
  

    var body: some View {
        ZStack{
            Color(hex: "8A47EB")
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
                .offset(x:0,y:-230)
            
            Text("Please enter your Email")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
                .offset(x:-50,y:50)
       
            
            TextField("Email", text: $email)
                .frame(height: 50)
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 15))
                .textFieldStyle(PlainTextFieldStyle())
                .background(Color(.systemGray6).opacity(0.5))
                .cornerRadius(30)
                .padding(.horizontal,20)
                .padding(.top,1)
            
           
            .padding(.top,220)

          
            
            Button(action: {
               
            }) {
                Text("Confirm")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.vertical, 16)
                    .frame(width: 290,height: 35)
                    .background(
                        RoundedRectangle(cornerRadius: 177)
                            .stroke(Color.white, lineWidth: 2)
                    )
                
            }
            .padding(.top, 400)
            
            
        }
        .ignoresSafeArea()

        
  
    }
}

struct forgetPassword_Previews: PreviewProvider {
    static var previews: some View {
        forgetPassword()
    }
}

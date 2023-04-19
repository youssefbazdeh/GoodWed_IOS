//
//  singup.swift
//  goodwed
//
//  Created by omarKaabi on 7/4/2023.
//

import SwiftUI


struct singup: View {
    @StateObject var signupViewModel=SignupViewModel()

    @State private var email: String = ""
    @State private var fullname: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var selectedDate = Date()
    @State private var role = "user"
    @State private var xxx = false

    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }

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
            
            TextField("Fullname", text: $fullname)
                .frame(height: 50)
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 15))
                .textFieldStyle(PlainTextFieldStyle())
                .background(Color(.systemGray6).opacity(0.5))
                .cornerRadius(30)
                .padding(.horizontal,20)
                .padding(.top,-100)
            
            TextField("Username", text: $username)
                .frame(height: 50)
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 15))
                .textFieldStyle(PlainTextFieldStyle())
                .background(Color(.systemGray6).opacity(0.5))
                .cornerRadius(30)
                .padding(.horizontal,20)
                .padding(.top,-20)
            
            TextField("Email", text: $email)
                .frame(height: 50)
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 15))
                .textFieldStyle(PlainTextFieldStyle())
                .background(Color(.systemGray6).opacity(0.5))
                .cornerRadius(30)
                .padding(.horizontal,20)
                .padding(.top,110)
            
            HStack{
                Text("Pick Birthday")
                    .foregroundColor(.white)
                DatePicker(
                    "",
                selection: $selectedDate,
                displayedComponents: [.date]
                )
                .accentColor(.white)
                .labelsHidden()
                Text(dateFormatter.string(from: selectedDate))
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.gray)
            }
            .padding(.top,220)

            SecureField("Password", text: $password)
                .frame(height: 50)
                .foregroundColor(.black)
                .padding(EdgeInsets(top:0, leading: 20, bottom: 0, trailing: 15))
                .textFieldStyle(PlainTextFieldStyle())
                .background(Color(.systemGray6).opacity(0.5))
                .cornerRadius(30)
                .padding(.horizontal,20)
                .padding(.top,330)
            
            
            Button(action: {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let birthDateString = dateFormatter.string(from: selectedDate)
                print(birthDateString)
                self.xxx=true
                let request = SignupRequest(username: username, fullname: fullname,email: email, password: password, datedenaissance: birthDateString,role: role)
                
                signupViewModel.signup(request: request) { result in
                    switch result {
                    case .success(let response):
                        // Handle successful sign up
                        print(response)
                        // Dismiss the sign in view after successful sign up

                        // Redirect to login page
                        
                    case .failure(let error):
                        // Handle error
                        print(error.localizedDescription)
                    }
                }
            }) {
                Text("Sign up")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.vertical, 16)
                    .frame(width: 290,height: 35)
                    .background(
                        RoundedRectangle(cornerRadius: 177)
                            .stroke(Color.white, lineWidth: 2)
                    )
                
            }

            .padding(.top, 500)
            if xxx {
                NavigationLink(destination: LoginView(), isActive: $xxx){
                    EmptyView()
                }
            }
            
        }
        .ignoresSafeArea()

        
  
    }
}

struct singup_Previews: PreviewProvider {
    static var previews: some View {
        singup()
    }
}

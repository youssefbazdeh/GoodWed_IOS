//
//  ProfilePage.swift
//  goodwed
//
//  Created by omarKaabi on 7/4/2023.
//

import SwiftUI

struct ProfilePage: View {
    
    @StateObject var loginViewModel = LoginViewModel()
    @State var show = false

    var body: some View {
        NavigationLink(destination: ContentView().navigationBarHidden(true), isActive: $show){
            VStack{
                
              
                Button(action: {
                    // button action here
                    self.show=true
                    loginViewModel.logout()
                   
                }) {
                    Text("Logout")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 290, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 177)
                                .fill(Color(#colorLiteral(red: 0.5411764979, green: 0.2784313858, blue: 0.9215686321, alpha: 1)))
                        )
                }
                .padding(.top,500)
            }
        }
 
  
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}

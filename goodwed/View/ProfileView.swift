//
//  ProfileView.swift
//  App-IOS
//
//  Created by Bilel Ouerghi on 14/4/2023.
//

import SwiftUI


struct ProfileView: View {
    @State var isLinkActive = false
    @ObservedObject var viewModel = ProfileViewModel()
    @StateObject var loginViewModel = LoginViewModel()
    @State var show = false
    @State private var fullname = ""
    @State private var username = ""
    

        
    var body: some View {
        NavigationView{
            ZStack {
                Color(UIColor(red: 0.81, green: 0.91, blue: 0.97, alpha: 1.00))
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    List{
                        
                        
                            
                            if let fullname = viewModel.user?.fullname{
                                Text("Fullname : \(fullname)")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                            if let username = viewModel.user?.username{
                                Text("Username : \(username)")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                            
                           
                           
                           
                            if let email = viewModel.user?.email{
                                Text("E-mail : \(email)")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                    .padding()
                            }
                            
                            
                        if let datedenaissance = viewModel.user?.datedenaissance,
                           let formattedDate = formatDate(datedenaissance) {
                            Text("D.naissance : \(formattedDate)")
                                .font(.headline)
                                .foregroundColor(.gray)
                                .padding()
                        }

                             
                           

                        
                        Spacer()
                        
                        NavigationLink(destination: EditProfileView(viewModel: viewModel), isActive:$isLinkActive){
                            Button(action: {
                                self.isLinkActive=true
                            }, label: {
                                Text("Edit your profile")
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                            })
                        }
                        
                        
                    }.listStyle(InsetGroupedListStyle())
                }
               
                    
               
                
                .onAppear{
                    viewModel.fetchUser()
                }
                .padding()
            }
        }
        
        NavigationLink(destination: ContentView(), isActive: $show){
            VStack{
                
              
                Button(action: {
                    
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
func formatDate(_ dateStr: String) -> String? {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd MMM yyyy"

    if let date = dateFormatterGet.date(from: dateStr) {
        return dateFormatterPrint.string(from: date)
    } else {
        return nil
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

//
//  EditProfileView.swift
//  App-IOS
//
//  Created by Bilel Ouerghi on 14/4/2023.
//

import SwiftUI

struct EditProfileView: View {
    @State var image: UIImage?
    @State var shouldShowImagePicker = false
    @State private var username: String=""
    //@State private var password: String=""
    @State private var fullname: String=""
    @State private var email: String=""
    @State private var datenaissance: String=""
    
    @ObservedObject var viewModel = ProfileViewModel()
    var body: some View {
        ZStack {
            Color(UIColor(red: 0.81, green: 0.91, blue: 0.97, alpha: 1.00))
                .edgesIgnoringSafeArea(.all)
            VStack{
                ZStack(alignment: .top) {
                    Button {
                        shouldShowImagePicker.toggle()
                    } label: {
                       
                        
                                 
                        
                    }
                }.padding()
                
                TextField("username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("fullname", text: $fullname)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField("email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
              
                TextField("Date", text: $datenaissance)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            
                
                
                Section {
                    Button("Save Changes") {
                        let request = UpdateUserRequest(username: username, fullname: fullname, email: email, datedenaissance: datenaissance)
                        viewModel.updateUser(request: request) {
                            // handle completion, e.g.:
                            print("User updated successfully!")
                        }
                    }
                }
            }
            if !viewModel.errorMessage.isEmpty {
                Text(viewModel.errorMessage)
                    .foregroundColor(.red)
            }
            }
            .padding()
            .navigationViewStyle(StackNavigationViewStyle())
            /*.fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
             ImagePicker(image: $image)
             .ignoresSafeArea()
             }*/
        }
    }
    


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}

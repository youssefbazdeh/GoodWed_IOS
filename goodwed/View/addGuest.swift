//
//  addChecklist.swift
//  goodwed
//
//  Created by omarKaabi on 13/4/2023.
//

import SwiftUI
import Photos

struct addGuest: View {
    @StateObject var guestViewModel=GuestViewModel()

    @State private var name: String = ""
    @State private var lastname: String = ""
    @State private var groupe: String = ""
    @State private var selectedsexe = ""
    let sexoptions = ["Homme","Femme","Lehou Lehou"]
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var adresse: String = ""
    @State private var note: String = ""

    
    var body: some View {
        
            
            VStack(alignment: .leading) {
                TextField("Name", text: $name)
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.horizontal, 20)
                
                TextField("LastName", text: $lastname)
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.horizontal, 20)
                
                TextField("Groupe", text: $groupe)
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.horizontal, 20)
                
             
                
                Picker("Sexe", selection: $selectedsexe){
                    ForEach(sexoptions, id: \.self){option in
                        Text(option)
                    }
                }
                
                TextField("Phone", text: $phone)
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.horizontal, 20)
                
                TextField("Email", text: $email)
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.horizontal, 20)
                
                TextField("Adresse", text: $adresse)
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.horizontal, 20)
                
                TextField("Note", text: $note)
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.horizontal,20)
                
                
                VStack{
                    Button(action: {
                      
                        let request = GuestRequest(name:name,lastname:lastname,sexe:selectedsexe,groupe:groupe,phone:phone,email: email,adresse:adresse,note:note)
                        guestViewModel.AddGuestt(request: request) { result in
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
                        Text("Add guest")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 290, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 177)
                                    .fill(Color(#colorLiteral(red: 0.5411764979, green: 0.2784313858, blue: 0.9215686321, alpha: 1)))
                            )
                    }
                }
                .padding(.horizontal,45)
            }
            .padding(.top, 20)
    
        }
    }
    

    
  




struct addGuest_Previews: PreviewProvider {
    static var previews: some View {
        addGuest()
    }
}

//
//  addChecklist.swift
//  goodwed
//
//  Created by omarKaabi on 13/4/2023.
//

import SwiftUI
import Photos

struct addBudget: View {
    @StateObject var budgetViewModel=BudgetViewModel()

    @State private var nom: String = ""
    @State private var categorie: String = ""
    @State private var montant: String = ""
    @State private var note: String = ""


    
    var body: some View {
        
            
            VStack(alignment: .leading) {
                TextField("Name", text: $nom)
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.horizontal, 20)
                
                TextField("Categorie", text: $categorie)
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.horizontal, 20)
                
                TextField("Amount", text: $montant)
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.horizontal, 20)
                
         
                
                TextField("Note", text: $note)
                    .padding(.all, 10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
                    .padding(.horizontal, 20)

             
                
                
                VStack{
                    Button(action: {
                      
                        let request = BudgetRequest(nom:nom,categorie: categorie,montant: montant,note:note)
                        budgetViewModel.AddBudget(request: request) { result in
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
                        Text("Add Budget")
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
    

    
  



struct addBudget_Previews: PreviewProvider {
    static var previews: some View {
        addBudget()
    }
}

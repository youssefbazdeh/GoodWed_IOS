//
//  GuestsPage.swift
//  goodwed
//
//  Created by omarKaabi on 7/4/2023.
//

import SwiftUI

struct GuestsPage: View {
    @State private var showAddGuest = false
    @StateObject var guestViewModel = GuestViewModel()
    @State private var showActionSheet = false
    @State private var selectedID = ""
    

    var body: some View {
        NavigationView {
            
            ScrollView(.horizontal, showsIndicators: false) {
                      HStack(spacing: 20) {
                          ForEach(guestViewModel.guests, id: \.self) { guest in
                              Button(action: {
                                  
                                  self.showActionSheet = true
                                  self.selectedID = guest._id

                              }){
                                  BabyCardView2(guest: guest)
                                  
                              }
                              .actionSheet(isPresented: $showActionSheet) {
                                  ActionSheet(title: Text("Modify/Delete Guest"), buttons: [
                                    .default(Text("Modify")) {
                                        
                                    },
                                    .default(Text("Delete")) {
                                        guestViewModel.deleteGuestet(id: selectedID)
                                    },
                                    .cancel()
                                    
                                  ])
                              }
                            
                          }
                          }
                      
                      .padding(.horizontal, 20)
                      .padding(.top, 10)
                      .onAppear {print("Checklists in ChecklistView: \(guestViewModel.guests)")}
                    
                  }

                   .navigationBarTitle("Guests")
                   .navigationBarItems(trailing:
                       Button(action: {
                           self.showAddGuest=true
                           print("pressed button")
                       }) {
                           Image(systemName: "plus")
                       }
                   )
            if showAddGuest {
                NavigationLink(destination: addGuest(), isActive: $showAddGuest) {EmptyView()}
}
               }
    }
}

struct GuestsPage_Previews: PreviewProvider {
    static var previews: some View {
        GuestsPage()
    }
}

struct BabyCardView2: View {
    var guest: guest

    var body: some View {
        VStack(alignment: .center) {
            

        
            
            Text(guest.name)
                .foregroundColor(Color.white)
                .font(.system(size: 20, design: .rounded).weight(.light))
            
            Text(guest.phone)
                .foregroundColor(Color.white)
                .font(.system(size: 20, design: .rounded).weight(.light))
            
            Text(guest.email)
                .foregroundColor(Color.white)
                .font(.system(size: 20, design: .rounded).weight(.light))
            
            Text(guest.adresse)
                .foregroundColor(Color.white)
                .font(.system(size: 20, design: .rounded).weight(.light))
          
                
            }
        .padding(20)
        .background(Color.black.opacity(0.5))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.7), radius: 5, x: 0, y: 4)
    }
}

//
//  ContentView.swift
//  goodwed
//
//  Created by omarKaabi on 8/5/2023.
//

import SwiftUI

struct ContentView2: View {
    
    @ObservedObject var viewModel=GuestViewModel()
    @State private var showAddGuest = false

    
    var body: some View {
        NavigationView {
            List(viewModel.guests) { guest in
                NavigationLink(destination: DetailView(guest: guest)) {
                    ContactRow(guest: guest)
                }
            }
            .navigationBarTitle("Guests")
            .navigationBarItems(trailing: 
                 NavigationLink(destination: addGuest(), isActive: $showAddGuest) {
                Button(action: {
                self.showAddGuest=true
                print("pressed button")
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.black)
            }}
                
            )
        }
        
   
     
     
    }
    }


struct ContactRow: View {
    
    let guest: guest
    
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            VStack(alignment: .leading) {
                Text(guest.name)
                    .font(.headline)
                Text(guest.note)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

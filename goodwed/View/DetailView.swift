//
//  DetailView.swift
//  goodwed
//
//  Created by omarKaabi on 8/5/2023.
//

import SwiftUI

struct DetailView: View {
    
    let guest: guest
    @StateObject var checklistViewModel = ChecklistViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Image("login")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipped()
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(guest.name)
                    .font(.title)
                
                Text(guest.phone)
                    .font(.headline)
                
                Text(guest.email)
                    .font(.headline)
                
                Text(guest.adresse)
                    .font(.headline)
                
                Text(guest.note)
                    .font(.headline)
                
                Spacer()
            }
            .padding()
            
            Spacer()
        }
        .navigationBarTitle(guest.name).hCenter()
    }
}

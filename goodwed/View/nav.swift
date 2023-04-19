//
//  HomePage.swift
//  goodwed
//
//  Created by omarKaabi on 7/4/2023.
//

import SwiftUI

struct nav: View {
    var body: some View {
        TabView{
            HomePage()
                .tabItem(){
                Image(systemName: "house")
                Text("Home")
            }
            
            Checklist()
                .tabItem(){
                Image(systemName: "checklist")
                Text("Checklist")
            }
            
            
            GuestsPage()
                .tabItem(){
                Image(systemName: "person.3")
                Text("Guests")
            }
           
            BudgetView()
                .tabItem(){
                Image(systemName: "person.crop.circle.fill")
                Text("Budget")
            }
            ProfilePage()
                .tabItem(){
                Image(systemName: "person.crop.circle.fill")
                Text("Profile")
            }
            
        }
    }
}

struct nav_Previews: PreviewProvider {
    static var previews: some View {
        nav()
    }
}

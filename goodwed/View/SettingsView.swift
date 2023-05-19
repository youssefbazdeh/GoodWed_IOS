//
//  SettingsView.swift
//  goodwed
//
//  Created by omarKaabi on 11/5/2023.
//

import SwiftUI

import SwiftUI

struct SettingsView: View {
    @State private var isInformationShowing = false
    @State private var isDarkModeEnabled = false
    @State private var isMapShowing = false
    @State private var isServiceShowing = false
    @StateObject var loginViewModel = LoginViewModel()
    @State var show = false
    

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Informations personnelles")) {
                    Button(action: {
                        
                        isInformationShowing = true
                    }) {
                        HStack {
                            Text("My Informations")
                                .foregroundColor(Color.black)
                            Spacer()
                            Image(systemName: "arrow.right")
                                .foregroundColor(Color.black)
                        }
                        
                        
                    }
         
                }
                Section(header: Text("Autres")) {
                    HStack {
                        Button(action: {
                            isMapShowing = true
                        }) {
                            HStack{
                                Text("Map")
                                    .foregroundColor(Color.black)
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                    
                    Toggle("Mode sombre", isOn: $isDarkModeEnabled)
                        .onChange(of: isDarkModeEnabled) { newValue in
                            if newValue {
                                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                            } else {
                                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                            }
                        }
                }
                
                
                
               
                    
                    Button(action: {
                        
                        self.show=true
                        loginViewModel.logout()
                    }){
                        Label("LogOut", systemImage: "power")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                if show {
                    NavigationLink(destination: ContentView(), isActive: $show){
                        EmptyView()
                        
                    }
                }
                
                

                
            }
            .navigationTitle("Profil")
        }
        .sheet(isPresented: $isInformationShowing) {
            ProfileView()
        }.sheet(isPresented: $isServiceShowing) {
            ProfileView()
        }
        .sheet(isPresented: $isMapShowing) {
            MapView()
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


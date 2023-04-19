//
//  Checklist.swift
//  goodwed
//
//  Created by omarKaabi on 13/4/2023.
//

import SwiftUI
struct Checklist: View {
    @State private var showAddChecklist = false
    @StateObject var checklistViewModel = ChecklistViewModel()
    @State private var showActionSheet = false
    @State private var selectedID = ""


    var body: some View {
        NavigationView {
        
            
            ScrollView(.horizontal, showsIndicators: false) {
                      HStack(spacing: 20) {
                          ForEach(checklistViewModel.checklists, id: \.self) { checklist in
                              Button(action: {
                                  
                                  self.showActionSheet = true
                                  self.selectedID = checklist._id

                              }){
                                  BabyCardView(checklist: checklist)
                                  
                              }
                              .actionSheet(isPresented: $showActionSheet) {
                                  ActionSheet(title: Text("Modify/Delet Task"), buttons: [
                                    .default(Text("Modify")) {
                                        
                                    },
                                    .default(Text("Delete")) {
                                        checklistViewModel.deleteChecklist(id: selectedID)
                                    },
                                    .cancel()
                                    
                                  ])
                              }
                            
                          }
                          }
                      
                      .padding(.horizontal, 20)
                      .padding(.top, 10)
                      .onAppear {print("Checklists in ChecklistView: \(checklistViewModel.checklists)")}
                    
                  }

                   .navigationBarTitle("Checklist")
                   .navigationBarItems(trailing:
                       Button(action: {
                           self.showAddChecklist=true
                           print("pressed button")
                       }) {
                           Image(systemName: "plus")
                       }
                   )
            if showAddChecklist {
                NavigationLink(destination: addChecklist(), isActive: $showAddChecklist) {EmptyView()}
}
               }
    }
}

struct Checklist_Previews: PreviewProvider {
    static var previews: some View {
        Checklist()
    }
}

struct BabyCardView: View {
    var checklist: checklist

    var body: some View {
        VStack(alignment: .center) {
            
            if let url = URL(string: checklist.image) {
                            
                            AsyncImage(url:url) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 200, height:250 )
                                        .clipShape(Rectangle())
                                        .cornerRadius(10)
                                    
                                        .clipShape(Rectangle())
                                case .failure(let error):
                                    Text(error.localizedDescription)
                                case .empty:
                                    Rectangle().foregroundColor(Color .gray).padding(.top,10)
                                @unknown default:
                                    Text("Unknown error")
                                }
                            } } else {
                                Text("Invalid URL")
                            }
            
            

            /* HStack{
                Button(action: {
                
                }) {
                Image( systemName: "heart.fill")
                
                .foregroundColor(Color.red)
                .frame(width: 10, height: 10)
                .font(.system(size: 30))
                
             }}
             */
        
            
            Text(checklist.nom)
                .foregroundColor(Color.white)
                .font(.system(size: 20, design: .rounded).weight(.light))
            
            Text(checklist.status)
                .foregroundColor(Color.white)
                .font(.system(size: 20, design: .rounded).weight(.light))
          
                
            }
        .padding(20)
        .background(Color.white.opacity(0.5))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.7), radius: 5, x: 0, y: 4)
    }
}


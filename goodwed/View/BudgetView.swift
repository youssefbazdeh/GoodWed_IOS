//
//  BudgetView.swift
//  goodwed
//
//  Created by OmarKaabi on 19/4/2023.
//

import SwiftUI

struct BudgetView: View {
    @StateObject var budgetViewModel = BudgetViewModel()
    @State private var showActionSheet = false
    @State private var selectedID = ""
    @State private var showAddBudget = false

    var body: some View {
        NavigationView {
                   
            ScrollView(.horizontal, showsIndicators: false) {
                      HStack(spacing: 20) {
                          ForEach(budgetViewModel.budgets, id: \.self) { budget in
                              Button(action: {
                                  
                                  self.showActionSheet = true
                                  self.selectedID = budget._id

                              }){
                                  BabyCardView1(budget: budget)
                                  
                              }
                              .actionSheet(isPresented: $showActionSheet) {
                                  ActionSheet(title: Text("Modify/Delet Budget"), buttons: [
                                    .default(Text("Modify")) {
                                        
                                    },
                                    .default(Text("Delete")) {
                                        budgetViewModel.deleteBudget(id: selectedID)
                                    },
                                    .cancel()
                                    
                                  ])
                              }
                            
                          }
                          }
                      
                      .padding(.horizontal, 20)
                      .padding(.top, 10)
                      .onAppear {print("Checklists in ChecklistView: \(budgetViewModel.budgets)")}
                    
                  }

                   .navigationBarTitle("Budget")
                   .navigationBarItems(trailing:
                       Button(action: {
                           self.showAddBudget=true
                           print("pressed button")
                       }) {
                           Image(systemName: "plus")
                       }
                   )
            if showAddBudget {
                NavigationLink(destination: addBudget(), isActive: $showAddBudget) {EmptyView()}
}
               }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView()
    }
}

struct BabyCardView1: View {
    var budget: budget

    var body: some View {
        VStack(alignment: .center) {
            

        
            
            Text(budget.nom)
                .foregroundColor(Color.white)
                .font(.system(size: 20, design: .rounded).weight(.light))
            
            Text(budget.categorie)
                .foregroundColor(Color.white)
                .font(.system(size: 20, design: .rounded).weight(.light))
            
            Text(budget.montant)
                .foregroundColor(Color.white)
                .font(.system(size: 20, design: .rounded).weight(.light))
            
            Text(budget.note)
                .foregroundColor(Color.white)
                .font(.system(size: 20, design: .rounded).weight(.light))
          
                
            }
        .padding(20)
        .background(Color.black.opacity(0.5))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.7), radius: 5, x: 0, y: 4)
    }
}

//
//  User.swift
//  CarLovers
//
//  Created by DaliCharf on 31/3/2023.
//

import Foundation
import UIKit



struct BudgetRequest: Encodable {
    let nom: String
    let categorie: String
    let montant: String
    let note: String
    
}

struct BudgetResponse: Decodable {
    let status: String
    let message: String
}
struct ErrorResponse3: Decodable {
    let message: String
}


struct budget: Decodable,Hashable {
    let _id: String
    let nom: String
    let categorie: String
    let montant: String
    let note: String
    let __v: Int
}

struct UpdateBudgetRequest: Encodable {
    let nom: String
    let categorie: String
    let montant: String
    let note: String
    
}

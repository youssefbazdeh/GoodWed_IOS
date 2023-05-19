//
//  User.swift
//  CarLovers
//
//  Created by DaliCharf on 31/3/2023.
//

import Foundation
import UIKit



struct ChecklistRequest: Encodable {
    let nom: String
    let type: String
    let note: String
    let image: String
    let date: String
    let status: String
    
}

struct ChecklistResponse: Decodable {
    let status: String
    let message: String
    let data: checklist
}
struct ErrorResponse1: Decodable {
    let message: String
}


struct checklist: Decodable, Hashable ,Identifiable{
    let _id: String
    let nom: String
    let type: String
    let note: String
    let image: String
    let date: String
    let status: String
    let __v: Int
    var id: String{_id}

}



struct UpdateChecklistRequest: Encodable {
    let nom: String
    let type: String
    let note: String
    let image: String
    let date: String
    let status: String
}


//
//  User.swift
//  CarLovers
//
//  Created by DaliCharf on 31/3/2023.
//

import Foundation
import UIKit



struct GuestRequest: Encodable {
    let name: String
    let lastname: String
    let sexe: String
    let groupe: String
    let phone: String
    let email: String
    let adresse: String
    let note: String
    
}

struct GuestResponse: Decodable {
    let status: String
    let message: String
}
struct ErrorResponse2: Decodable {
    let message: String
}


struct guest: Decodable,Hashable ,Identifiable{
    let _id: String
    let name: String
    let lastname: String
    let sexe: String
    let groupe: String
    let phone: String
    let email: String
    let adresse: String
    let note: String
    let __v: Int
    var id: String{_id}
}

struct UpdateGuestRequest: Encodable {
    let name: String
    let lastname: String
    let sexe: String
    let groupe: String
    let phone: String
    let email: String
    let adresse: String
    let note: String
}

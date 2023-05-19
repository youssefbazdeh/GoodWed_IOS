//
//  news.swift
//  goodwed
//
//  Created by omarKaabi on 17/5/2023.
//

struct news: Decodable,Hashable,Identifiable{
    let id: String
    let title: String
    let content_text: String
    let image: String
    let date_published: String
    var _id: String{id}

  
}


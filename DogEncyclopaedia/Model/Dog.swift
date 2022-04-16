//
//  Dog.swift
//  DogEncyclopaedia
//
//  Created by Long Hei Au on 6/4/2022.
//

import Foundation
struct Dog: Decodable, Identifiable{
    let id: Int
    let dog_name_en:String
    let dog_name_cn:String
    let description:String
}

//
//  ReadData.swift
//  DogEncyclopaedia
//
//  Created by Jacky Wong on 6/4/2022.
//

import Foundation
import SwiftUI

class ReadData: ObservableObject  {
    @Published var dogs = [Dog]()
    init(){
        loadData()
    }
    func loadData()  {
        let asset = NSDataAsset(name: "Dogs", bundle: Bundle.main)
        if let json = try? JSONSerialization.jsonObject(with: asset!.data, options: .allowFragments) as? [Any] {
            for item in json {
                let object = item as? [String: Any]
                let id = object!["id"] as! Int
                let dog_name_en = object!["dog-name-en"] as! String
                let dog_name_cn = object!["dog-name-cn"] as! String
                let description = object!["description"] as! String
                dogs.append(Dog(id: id,dog_name_en:dog_name_en,dog_name_cn:dog_name_cn,description:description))
            }
        }
    }
}

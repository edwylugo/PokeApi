//
//  PokemonData.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import Foundation
import ObjectMapper

class PokemonData: Mappable {
    required init?(map: Map) {}
    
    var name: String? = ""
    var url: String? = ""
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.url <- map["url"]
    }
}

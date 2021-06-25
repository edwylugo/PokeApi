//
//  PokemonTypes.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import Foundation
import ObjectMapper

class PokemonTypes: Mappable {
    required init?(map: Map) {}
    
    var name: String? = ""
    
    func mapping(map: Map) {
        self.name <- map["name"]
    }
}

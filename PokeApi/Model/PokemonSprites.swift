//
//  PokemonSprites.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import Foundation
import ObjectMapper

class PokemonSprites: Mappable {
    required init?(map: Map) {}

    var front_shiny: String? = ""
    var front_default: String? = ""
    
    func mapping(map: Map) {
        self.front_shiny <- map["front_shiny"]
        self.front_default <- map["front_default"]
    }
    
}

//
//  PokemonDetail.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import Foundation
import ObjectMapper

class PokemonDetail: Mappable {
    required init?(map: Map) {}
    
    var name: String? = ""
    var id: Int? = 0
    var order: Int? = 0
    var sprites: PokemonSprites?
    var stats: [PokemonStats]? = []
    var types: [PokemonTypes]? = []
    
    func mapping(map: Map) {
        self.name <- map["name"]
        self.id <- map["id"]
        self.order <- map["order"]
        self.sprites <- map["sprites"]
        self.stats <- map["stats"]
        self.types <- map["types"]
    }
    
}

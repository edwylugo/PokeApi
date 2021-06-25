//
//  PokemonStats.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import Foundation
import ObjectMapper

class PokemonStats: Mappable {
    required init?(map: Map) {}

    var base_stat: Int? = 0
    var effort: Int? = 0
    var stat: PokemonNameStat?
    
    func mapping(map: Map) {
        self.base_stat <- map["base_stat"]
        self.effort <- map["effort"]
        self.stat <- map["stat"]
    }
}

class PokemonNameStat: Mappable {
    required init?(map: Map) {}

    var name: String? = ""
    var url: String? = ""
  
    func mapping(map: Map) {
        self.name <- map["name"]
        self.url <- map["url"]
    }
}

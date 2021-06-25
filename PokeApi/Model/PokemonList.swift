//
//  PokemonList.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import Foundation
import ObjectMapper

class PokemonList: Mappable {
    required init?(map: Map) {}
    
    var count: Int? = 0
    var next: String? = ""
    var previous: String? = ""
    var results: [PokemonData]? = []
    
    func mapping(map: Map) {
        self.count <- map["count"]
        self.next <- map["next"]
        self.previous <- map["previous"]
        self.results <- map["results"]
    }
}

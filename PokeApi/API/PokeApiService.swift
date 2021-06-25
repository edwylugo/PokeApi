//
//  PokeApiService.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import Alamofire
import AlamofireObjectMapper

class PokeApiService {
    static let shared = PokeApiService()
    
    //MARK: - Get Pokemons
    func fetchPokemons(page: Int = 0, onComplete: @escaping (PokemonList?) -> Void) {
        let url: String
        let offset = page * ITEMS
        url = "\(API_BASE)\(LIMIT)\(ITEMS)\(OFFSET)\(offset)"
        print("DEBUG: url...: \(url)")
        
        Alamofire.request(url).responseObject { (response: DataResponse<PokemonList>) in
            onComplete(response.result.value)
        }
    }
    
    //MARK: - Get Pokemon Info
    func fetchPokemonInfo(name: String?, onComplete: @escaping (PokemonDetail?) -> Void) {
        let url = API_BASE + "\(name!)/"
        print("DEBUG: url...: \(url)")
        Alamofire.request(url).responseObject { (response: DataResponse<PokemonDetail>) in
            onComplete(response.result.value)
        }
    }
}

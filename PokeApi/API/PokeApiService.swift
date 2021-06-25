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
    func fetchPokemons(name: String?, id: Int, page: Int = 0, onComplete: @escaping (PokemonList?) -> Void) {
        let url: String
        url = "\(API_BASE)\(LIMIT)\(ITEMS)\(OFFSET)\(page)"
        print("DEBUG: url...: \(url)")
        
        Alamofire.request(url).responseObject { (response: DataResponse<PokemonList>) in
            onComplete(response.result.value)
        }
    }
    
    //MARK: - Get Pokemon Info
    func fetchPokemonInfo(name: String?, id: Int, onComplete: @escaping (PokemonDetail?) -> Void) {
        let url = API_BASE + "\(name!)/"
        print("DEBUG: url...: \(url)")
        Alamofire.request(url).responseObject { (response: DataResponse<PokemonDetail>) in
            onComplete(response.result.value)
        }
    }
}

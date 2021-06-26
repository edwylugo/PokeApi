//
//  PokemonDetailsViewModel.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import Foundation
import UIKit


protocol PokemonDetailsNavigation: AnyObject {

}

protocol PokemonDetailsViewModelProtocol {
    var pokeDetail: Observable<PokemonDetail?> { get }
    var pokeStats:  Observable<[PokemonStats]> { get }
    var pokemon_name: String { get }
    func fetchPokemonDetails()

}

struct PokemonDetailsViewModel: PokemonDetailsViewModelProtocol {
    private var navigationDelegate: PokemonDetailsNavigation
    var pokeDetail: Observable<PokemonDetail?>
    var pokeStats: Observable<[PokemonStats]>
    var pokemon_name: String
    
    init(navigationDelegate: PokemonDetailsNavigation, pokemon_name: String) {
        self.navigationDelegate = navigationDelegate
        self.pokemon_name = pokemon_name
        self.pokeDetail = Observable(nil)
        self.pokeStats = Observable([])
        
        fetchPokemonDetails()
    }
    
    func fetchPokemonDetails() {
        PokeApiService.shared.fetchPokemonInfo(name: pokemon_name) { (poke) in
            if let poke = poke {
                DispatchQueue.main.async {
                    self.pokeDetail.value = poke
                    self.pokeStats.value.append(contentsOf: poke.stats!)
                }
            }
        }
    }
}

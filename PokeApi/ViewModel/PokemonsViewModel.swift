//
//  PokemonsViewModel.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import Foundation
import UIKit

protocol PokemonsNavigationProtocol: AnyObject {
    func gotoPokemonDetails(pokemon_name: String)
}

protocol PokemonsViewModelProtocol {
    var error: Observable<Error?> { get }
    var isLoading: Observable<Bool> { get }
    var isPullRefresh: Observable<Bool> { get }
    var pokemons: Observable<[PokemonData]> { get }
    var loadingMovies: Bool { get set }
    var currentPage: Int { get set }
    
    func fetchPokemons()
    func pullRefresh()
    func selectPokemonItemAt(indexPath: IndexPath)
}

struct PokemonsViewModel: PokemonsViewModelProtocol {
    
    private var navigationDelegate: PokemonsNavigationProtocol
    var error: Observable<Error?>
    var isLoading: Observable<Bool>
    var isPullRefresh: Observable<Bool>
    var pokemons: Observable<[PokemonData]>
    var loadingMovies: Bool
    var currentPage: Int
    
    init(navigationDelegate: PokemonsNavigationProtocol) {
        self.navigationDelegate = navigationDelegate
        self.error = Observable(nil)
        self.isLoading = Observable(false)
        self.isPullRefresh = Observable(false)
        self.pokemons = Observable([])
        self.loadingMovies = false
        self.currentPage = 0
        fetchPokemons()
    }
    
    func fetchPokemons() {
        PokeApiService.shared.fetchPokemons(page: currentPage) { (poke) in
            if let poke = poke {
                self.pokemons.value.append(contentsOf: poke.results!)
            }
        }
    }
    
    func pullRefresh() {
        self.isPullRefresh.value = true
        self.pokemons.value.removeAll()
        
        PokeApiService.shared.fetchPokemons(page: currentPage) { (poke) in
            if let poke = poke {
                self.pokemons.value.append(contentsOf: poke.results!)
                self.isPullRefresh.value = false
            }
        }
    }
    
    func selectPokemonItemAt(indexPath: IndexPath) {
        guard pokemons.value.indices.contains(indexPath.row) else { return }
        let item = pokemons.value[indexPath.row]
        navigationDelegate.gotoPokemonDetails(pokemon_name: item.name!)
    }
    
}



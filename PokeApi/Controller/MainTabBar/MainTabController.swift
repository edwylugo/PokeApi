//
//  MainTabController.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import UIKit

class MainTabController: UITabBarController {
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    func configureViewControllers() {
        ///Pokemons
        let viewModelPokemons = PokemonsViewModel(navigationDelegate: self)
        let pokemons = PokemonsController(viewModel: viewModelPokemons)
        let nav1 = templateNavigationController(image: UIImage(systemName: "house"), rootViewController: pokemons, title: "Pokémons")
        
        
        let search = PokemonsSearchController()
        let nav2 = templateNavigationController(image: UIImage(systemName: "magnifyingglass"), rootViewController: search, title: "Search Pokémons")
        
        viewControllers = [nav1, nav2]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController, title: String?) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        return nav
    }

}

extension MainTabController: PokemonsNavigationProtocol {
    func gotoPokemonDetails(pokemon_name: String) {
        let viewModelPokemonDetails = PokemonDetailsViewModel(navigationDelegate: self, pokemon_name: pokemon_name)
        let details = PokemonDetailsController(viewModel: viewModelPokemonDetails)
        push(details)
    }
}

extension MainTabController: PokemonDetailsNavigation {

}

extension MainTabController: ResultSearchNavigationProtocol {
    func gotoPokemonDetail(pokemon_name: String) {
        let viewModelPokemonDetails = PokemonDetailsViewModel(navigationDelegate: self, pokemon_name: pokemon_name)
        let details = PokemonDetailsController(viewModel: viewModelPokemonDetails)
        push(details)
    }
    
    
}

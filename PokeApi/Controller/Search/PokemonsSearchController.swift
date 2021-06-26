//
//  PokemonsSearchController.swift
//  PokeApi
//
//  Created by Edwy Lugo on 26/06/21.
//

import UIKit

class PokemonsSearchController: UIViewController {
    
    //MARK: - Properties
    ///UI Text
    private let infoLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Enter the name of the favorite Pokémon to search for information or select button for results all Pokémons"
        label.textColor = .black
        label.numberOfLines = 4
        label.textAlignment = .center
        return label
    }()
    
    ///UI TextField Layout
    private lazy var searchContainerView: UIView = {
        let image = #imageLiteral(resourceName: "search_unselected")
        let view = Utilities().inputContainerView(withImage: image, textField: searchTextField)
        return view
    }()
    
    ///UI TextField
    private let searchTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Enter name Pokémon...")
        return tf
    }()
    
    ///UI Button Search
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search now", for: .normal)
        button.setTitleColor(.pokemonLabel, for: .normal)
        button.backgroundColor = .systemGroupedBackground
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    
    //MARK: - Selectors
    @objc func handleSearch() {
        if (searchTextField.text != "") {
            let name = "\(searchTextField.text?.description.lowercased() ?? "")"
            let viewModelPokemonDetails = PokemonDetailsViewModel(navigationDelegate: self, pokemon_name: name)
            let details = PokemonDetailsController(viewModel: viewModelPokemonDetails)
            push(details)
        } else {
            let viewModelResultSearch = ResultSearchViewModel(navigationDelegate: self)
            let controller = ResultSearchController(viewModel: viewModelResultSearch)
            push(controller)
        }
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(infoLabel)
        infoLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 24, paddingRight: 24)
        
        let stack = UIStackView(arrangedSubviews: [searchContainerView, searchButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: infoLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
        title = "Search Pokémons"
    }
}

extension PokemonsSearchController: PokemonDetailsNavigation {

}
extension PokemonsSearchController: ResultSearchNavigationProtocol {
    func gotoPokemonDetail(pokemon_name: String) {
        let viewModelPokemonDetails = PokemonDetailsViewModel(navigationDelegate: self, pokemon_name: pokemon_name)
        let details = PokemonDetailsController(viewModel: viewModelPokemonDetails)
        push(details)
    }
}

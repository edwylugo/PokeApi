//
//  ResultCell.swift
//  PokeApi
//
//  Created by Edwy Lugo on 26/06/21.
//

import UIKit

class ResultCell: UICollectionViewCell {
    //MARK: - Properties
    
    lazy var pokemonImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimension(width: 80, height: 80)
        iv.backgroundColor = .systemGroupedBackground
        iv.layer.cornerRadius = 80 / 2
        return iv
    }()
    
    var idPokemon: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "ID Pokémon..."
        label.numberOfLines = 1
        label.textColor = .pokemonLabel
        return label
    }()
    
    ///UI Overview Filme
    var namePokemon: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Name Pokemon..."
        label.numberOfLines = 2
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(pokemonImageView)
        pokemonImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        let stack = UIStackView(arrangedSubviews: [idPokemon,namePokemon])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: pokemonImageView.topAnchor, left: pokemonImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        stack.centerY(inView: pokemonImageView, leftAnchor: pokemonImageView.rightAnchor, paddingLeft: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - API
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func setupCell(with pokemon: PokemonData, pokemonId: Int) {
        let id = Utilities.changeID(pokemonId: pokemonId)
    
        let url = URL(string: "\(URLIMAGE)\(id)\(EXTENSION)" )
        pokemonImageView.kf.setImage(with: url)
    
        idPokemon.text = id
        namePokemon.text = "\(pokemon.name?.description ?? "")"
    }
}



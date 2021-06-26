//
//  PokeCell.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import UIKit
import Kingfisher

class PokeCell: UICollectionViewCell {
    //MARK: - Properties
    lazy var backColor: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        view.layer.cornerRadius = 24
        
        view.addSubview(pokeImageView)
        pokeImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4)
        
        pokeImageView.contentMode = .scaleAspectFit
        
        return view
    }()
    
    lazy var pokeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimension(width: 100, height: 180)
        iv.image = UIImage(named: "notimage")
        return iv
    }()
    
    var idLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.text = ""
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    var pokeNameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.text = ""
        label.textColor = .pokemonLabel
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(backColor)
        backColor.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0)
        
        addSubview(idLabel)
        idLabel.anchor(top: backColor.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 0)
        
        addSubview(pokeNameLabel)
        pokeNameLabel.anchor(top: idLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    func setupCell(with pokemon: PokemonData, pokemonId: Int) {
        let id = Utilities.changeID(pokemonId: pokemonId)
    
        let url = URL(string: "\(URLIMAGE)\(id)\(EXTENSION)" )
        pokeImageView.kf.setImage(with: url)
    
        idLabel.text = id
        pokeNameLabel.text = "\(pokemon.name?.description ?? "")"
    }
    
}

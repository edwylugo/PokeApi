//
//  PokeProfileHeader.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import UIKit
import Kingfisher

protocol PokeProfileHeaderDelegate: AnyObject {
    func handleDismissal()
}

class PokeProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    weak var delegate: PokeProfileHeaderDelegate?
    var id: String? = ""
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pokemonMain
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor,
                          paddingTop: 42, paddingLeft: 16)
        backButton.setDimension(width: 30, height: 30)

        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGroupedBackground
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.borderWidth = 5
        return iv
    }()
    
    private let pokeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .lightGray
        return label
    }()
    
    var statsTitle: UILabel =  {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Stats:"
        return label
    }()
    
    // MARK: - Lifecyle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)
    
        addSubview(profileImageView)
        profileImageView.anchor(top: containerView.bottomAnchor, left: leftAnchor, paddingTop: -24, paddingLeft: 8)
        profileImageView.setDimension(width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        
        let userDetailsStack = UIStackView(arrangedSubviews: [pokeNameLabel, idLabel, statsTitle])
        userDetailsStack.axis = .vertical
        userDetailsStack.distribution = .fillProportionally
        userDetailsStack.spacing = 4
        
        addSubview(userDetailsStack)
        userDetailsStack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor,
        right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingRight: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.addBottomLine(color: .black, height: 5)
    }
    
    // MARK: - Selectors
    @objc func handleDismissal() {
        delegate?.handleDismissal()
    }
    
    //MARK: - Helpers
    func setupCell(with pokemon: PokemonDetail) {
        let url = URL(string: "\(URLIMAGEMAIN)\(pokemon.id!)\(EXTENSION)" )
        profileImageView.kf.setImage(with: url)
        pokeNameLabel.text = pokemon.name
        idLabel.text = "#\(pokemon.id!)"
    }

}



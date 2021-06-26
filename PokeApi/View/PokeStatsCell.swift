//
//  PokeStatsCell.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import UIKit

class PokeStatsCell: UICollectionViewCell {
    
    var statsLabel: UILabel =  {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.setDimension(width: 130, height: 20)
        label.textAlignment = .right
        return label
    }()
    
    let gradientHorizontalBar: GradientHorizontalProgressBar = {
        let view = GradientHorizontalProgressBar()
        view.backgroundColor = .systemGroupedBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    var baseStatLabel: UILabel =  {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {

        let stack = UIStackView(arrangedSubviews: [statsLabel, gradientHorizontalBar, baseStatLabel])
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fill
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingRight: 10)
    
        gradientHorizontalBar.color = .random()
        gradientHorizontalBar.gradientColor = .white
        gradientHorizontalBar.progress = 0.7
    }
    
    func setupCell(with pokemonStats: PokemonStats) {
        statsLabel.text = pokemonStats.stat?.name
        gradientHorizontalBar.progress = CGFloat(pokemonStats.base_stat ?? 0)/100
        baseStatLabel.text = pokemonStats.base_stat?.description
    }
}

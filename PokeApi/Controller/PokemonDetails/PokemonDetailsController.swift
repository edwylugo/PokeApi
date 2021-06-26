//
//  PokemonDetailsController.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "PokeStatsCell"
private let headerIdentifier = "PokeProfileHeader"

class PokemonDetailsController: UICollectionViewController {
    
    //MARK: - Properties
    private var viewModel: PokemonDetailsViewModelProtocol

    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "background")
        return iv
    }()
    
    //MARK: - Lifecycle
    init(viewModel: PokemonDetailsViewModelProtocol) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - API
    
    //MARK: - Selectors

    //MARK: - Helpers
    
    func configureCollectionView() {
        
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(PokeProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        collectionView.register(PokeStatsCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .clear
        
        collectionView?.backgroundView = imageView
        
        
        
        
        
    }
    
    func setupBindings() {
        viewModel.pokeDetail.bind { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension PokemonDetailsController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokeStats.value.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokeStatsCell
        cell.setupCell(with: viewModel.pokeStats.value[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PokemonDetailsController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! PokeProfileHeader

        
        if let pokemonInfo = viewModel.pokeDetail.value {
            header.setupCell(with: pokemonInfo)
        }
    
        header.delegate = self
        
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PokemonDetailsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 30)
    }
}

extension PokemonDetailsController: PokeProfileHeaderDelegate {
    func handleDismissal() {
        onPop(animated: true)
    }
}

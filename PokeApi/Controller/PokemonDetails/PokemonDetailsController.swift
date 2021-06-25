//
//  PokemonDetailsController.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "PokeCell"
private let headerIdentifier = "PokeProfileHeader"

class PokemonDetailsController: UICollectionViewController {
    
    //MARK: - Properties
    private var viewModel: PokemonDetailsViewModelProtocol
    
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
        collectionView.register(PokeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
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
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokeCell
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PokemonDetailsController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! PokeProfileHeader

        
        if let pokemonInfo = viewModel.pokeDetail.value {
            let pokemonId = indexPath.row + 1
            header.setupCell(with: pokemonInfo, pokemonId: pokemonId)
        }
        
        
        header.delegate = self
        
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PokemonDetailsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

extension PokemonDetailsController: PokeProfileHeaderDelegate {
    func handleDismissal() {
        onPop(animated: true)
    }
}

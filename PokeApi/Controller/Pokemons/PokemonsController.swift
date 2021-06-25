//
//  PokemonsController.swift
//  PokeApi
//
//  Created by Edwy Lugo on 25/06/21.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "PokeCell"

class PokemonsController: UICollectionViewController {
    
    //MARK: - Properties
    private var viewModel: PokemonsViewModelProtocol
    var refreshControl = UIRefreshControl()
    
    //MARK: - Lifecycle
    init(viewModel:PokemonsViewModelProtocol) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureUI()
        setupBindings()
        addPullToRefresh()
    }
    
    //MARK: - API
    
    //MARK: - Selectors
    @objc private func pullRefresh() {
        viewModel.currentPage = 1
        viewModel.pullRefresh()
    }
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        collectionView.register(PokeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        title = "Pokémons"
    }
    
    func setupBindings() {
        viewModel.loadingMovies = true
        viewModel.pokemons.bind { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.viewModel.loadingMovies = false
                self.collectionView.reloadData()
            }
        }
        
        viewModel.isPullRefresh.bind { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                isLoading ? print() : self.refreshControl.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
    
    private func addPullToRefresh() {
        refreshControl.tintColor = .white
        refreshControl.addTarget(viewModel, action: #selector(pullRefresh), for: UIControl.Event.valueChanged)
        collectionView.addSubview(refreshControl)
    }

}

//MARK: - UICollectionViewDelegate/DataSource
extension PokemonsController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokemons.value.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PokeCell
        let pokemonInfo =  viewModel.pokemons.value[indexPath.row]
        let pokemonId = indexPath.row + 1
        cell.setupCell(with: pokemonInfo, pokemonId: pokemonId)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectPokemonItemAt(indexPath: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.pokemons.value.count - 1 && !viewModel.loadingMovies {
            viewModel.currentPage += 1
            if viewModel.pokemons.value.count > 0 {
                viewModel.fetchPokemons()
                print("Loading more pokemons....")
            }
        }
    }
 
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PokemonsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Utilities().sectionInsets.left
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / Utilities().itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

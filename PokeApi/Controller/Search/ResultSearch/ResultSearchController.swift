//
//  ResultSearchController.swift
//  PokeApi
//
//  Created by Edwy Lugo on 26/06/21.
//

import UIKit

private let reuseIdentifier = "ResultCell"

class ResultSearchController: UICollectionViewController {
    //MARK: - Properties
    private var viewModel: ResultSearchViewModelProtocol
    
    //MARK: - Lifecycle
    init(viewModel:ResultSearchViewModelProtocol) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Selectors
    @objc func handleClose() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        collectionView.register(ResultCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        title = "Result Search"
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(handleClose))
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
    }
}

//MARK: - UICollectionViewDelegate/DataSource
extension ResultSearchController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pokemons.value.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ResultCell
        let pokemonId = indexPath.row + 1
        cell.setupCell(with: viewModel.pokemons.value[indexPath.row], pokemonId: pokemonId)
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
            }
            print("Loading more pokémons")
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ResultSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}


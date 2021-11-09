//
//  ViewController.swift
//  MVVM
//
//  Created by Bruno Pastre on 09/11/21.
//

// Reativo ou nao
// MVVM model view viewmodel
// Model -> Modelo de dados
struct Cat {
    
}
// Modelo de dominio
class ShowCatUseCase {
    
}

// Features
// Listar gatinhos -> MVVM sem reatividade M -> Modelo de dados

// Chat -> MVVM Reativo Modelo de dados -> Modelo de dominio

import UIKit

final class PokemonListViewController: UIViewController {
    // MARK: - Properties
    
    private let viewModel = PokemonListViewModel()
    private lazy var pokemonTableView = PokemonListView()

    // MARK: - ViewController lifecycle
    
    override func loadView() {
        view = pokemonTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTableView.bind(dataSource: self)
    }
}

extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfPokemons
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PokemonCell") as? PokemonCell
        else { fatalError("No cell registered!") }
        let pokemonName = viewModel.name(forPokemonAt: indexPath.row)
        cell.configure(pokemonName: pokemonName)
        return cell
    }
}

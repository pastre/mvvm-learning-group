// Reativo ou nao
// Bidirecional
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
    
    private let viewModel = PokemonListViewModel(service: PokemonListService())
    private lazy var pokemonTableView = PokemonListView()

    // MARK: - ViewController lifecycle
    
    override func loadView() {
        view = pokemonTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTableView.bind(dataSource: self, delegate: self)
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadPokemons()
    }
}

extension PokemonListViewController: PokemonListViewModelDelegate {
    func reloadData() {
        pokemonTableView.reloadData()
    }
}

extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        guard distanceFromBottom < height else { return }
        viewModel.loadPokemons()
    }
}

// Closures
// Delegate

import Foundation

protocol PokemonListViewModelDelegate: AnyObject {
    func reloadData()
}

final class PokemonListViewModel {
    // MARK: - Properties
    
    private var canLoadPokemons = true
    private var pokemons: [Pokemon] = []
    private var currentUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    // MARK: - Dependencies
    
    private let mapper = PokemonMapper()
    private let service: PokemonListServiceProtocol
    weak var delegate: PokemonListViewModelDelegate?
    
    // MARK: - Initialization
    
    init(service: PokemonListServiceProtocol) {
        self.service = service
    }
    
    // MARK: - ViewModel
    
    func loadPokemons() {
        guard canLoadPokemons else { return }
        canLoadPokemons = false
        service.loadPokemons(for: currentUrl) { result in
            switch result {
            case let .success(apiResultDTO):
                let apiResult = self.mapper.apiResult(from: apiResultDTO)
                self.pokemons.append(contentsOf: apiResult.results)
                self.currentUrl = apiResult.next
                self.delegate?.reloadData()
            case let .failure(error):
                break // TODO
            }
            self.canLoadPokemons = true
        }
    }
    
    var numberOfPokemons: Int { pokemons.count }
    func name(forPokemonAt index: Int) -> String {
        pokemons[index].name
    }
}

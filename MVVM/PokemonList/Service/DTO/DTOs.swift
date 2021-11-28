import Foundation

// SRP -> Single responsability Principle

struct ApiResultDTO: Decodable {
    let pokemons: [PokemonDTO]
    let next: URL
}

struct PokemonDTO: Decodable {
    let name: String
}

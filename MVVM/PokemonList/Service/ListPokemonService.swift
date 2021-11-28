//
//  ListPokemonService.swift
//  MVVM
//
//  Created by Bruno Pastre on 16/11/21.
//

// Servico | Dominio

// UIKit | MVVM | Servicos

import Foundation

enum ApiError: Error {
    case apiError
    case parsing
}

protocol PokemonListServiceProtocol {
    func loadPokemons(for url: URL, completion: @escaping (Result<ApiResultDTO, ApiError>) -> Void)
}

final class PokemonListService: PokemonListServiceProtocol {
    func loadPokemons(for url: URL, completion: @escaping (Result<ApiResultDTO, ApiError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(.failure(.apiError))
                    return
                }
                guard let response = try? JSONDecoder().decode(ApiResultDTO.self, from: data) else {
                    completion(.failure(.parsing))
                    return
                }
                    completion(.success(response))
            }
        }.resume()
    }
}

//
//  PokemonListViewModelTests.swift
//  MVVMTests
//
//  Created by Bruno Pastre on 16/11/21.
//

import XCTest
@testable import MVVM

final class PokemonListViewModelTests: XCTestCase {
    
    // sut: System under test
    private let mock = PokemonListServiceMock()
    private lazy var sut = PokemonListViewModel(service: mock)
    
    // func test_whatYouretesting_whenAScenario_thenWhatIsExpected
    func test_numberOfPokemons_whenLoading_properlymatches() {
        // Given
        
        let expectedItemCount = Int.random(in: 10...1000)
        mock.resultToUse = .success(.init(
            results: .init(repeating: .init(name: "dummy"), count: expectedItemCount),
            next: .init(string: "http://google.com" )!
        ))
        sut.loadPokemons()
        
        // When
        
        let actualItemCount = sut.numberOfPokemons
        
        // Then
        
        XCTAssertEqual(expectedItemCount, actualItemCount)
    }
}

final class PokemonListServiceMock: PokemonListServiceProtocol {
    var resultToUse: Result<ApiResult, ApiError> = .failure(.parsing)
    func loadPokemons(for url: URL, completion: @escaping (Result<ApiResult, ApiError>) -> Void) {
        completion(resultToUse)
    }
}

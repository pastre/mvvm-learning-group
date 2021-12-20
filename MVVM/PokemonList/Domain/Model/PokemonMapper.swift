final class PokemonMapper {
    func apiResult(from dto: ApiResultDTO) -> ApiResult {
        .init(
            results: [],
            next: dto.next)
    }
    
    func pokemon(from dto: PokemonDTO) -> Pokemon {
        .init(name: dto.name)
    }
}

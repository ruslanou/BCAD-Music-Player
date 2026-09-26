struct SearchSongsUseCase {
    private let repository: SongRepository
    
    init(repository: SongRepository) {
        self.repository = repository
    }
    
    func execute(term: String) async throws -> [Song] {
        return try await repository.searchSongs(term: term)
    }
}

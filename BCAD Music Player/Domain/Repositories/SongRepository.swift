protocol SongRepository {
    func searchSongs(term: String) async throws -> [Song]
}

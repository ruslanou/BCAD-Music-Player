import Foundation
@testable import BCAD_Music_Player

final class MockSongRepository: SongRepository {
    var stubbedSongs: [Song] = []
    var stubbedError: Error?
    
    func searchSongs(term: String) async throws -> [Song] {
        if let error = stubbedError {
            throw error
        }
        return stubbedSongs
    }
}

import XCTest
@testable import BCAD_Music_Player

@MainActor
final class SearchSongsUseCaseTests: XCTestCase {
    
    func test_execute_returnsSongsFromRepository() async throws {
        let mockRepository = MockSongRepository()
        mockRepository.stubbedSongs = [
            Song(id: 1, title: "Test Song", artist: "Test Artist", album: "Test Album", artworkURL: nil, previewURL: nil)
        ]
        let useCase = SearchSongsUseCase(repository: mockRepository)
        
        let result = try await useCase.execute(term: "test")
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.title, "Test Song")
    }
    
    func test_execute_throwsErrorFromRepository() async {
        let mockRepository = MockSongRepository()
        mockRepository.stubbedError = NetworkError.requestFailed
        let useCase = SearchSongsUseCase(repository: mockRepository)
        
        do {
            _ = try await useCase.execute(term: "test")
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
}

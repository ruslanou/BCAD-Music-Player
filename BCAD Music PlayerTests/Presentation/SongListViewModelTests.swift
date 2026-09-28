import XCTest
@testable import BCAD_Music_Player

@MainActor
final class SongListViewModelTests: XCTestCase {
    
    func test_search_success_populatesSongs() async {
        let mockRepository = MockSongRepository()
        mockRepository.stubbedSongs = [
            Song(id: 1, title: "Song A", artist: "Artist A", album: "Album A", artworkURL: nil, previewURL: nil)
        ]
        let useCase = SearchSongsUseCase(repository: mockRepository)
        let viewModel = SongListViewModel(searchSongsUseCase: useCase, audioPlayer: AudioPlayerService())
        
        await viewModel.search(term: "test")
        
        XCTAssertEqual(viewModel.songs.count, 1)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_search_failure_setsErrorMessage() async {
        let mockRepository = MockSongRepository()
        mockRepository.stubbedError = NetworkError.requestFailed
        let useCase = SearchSongsUseCase(repository: mockRepository)
        let viewModel = SongListViewModel(searchSongsUseCase: useCase, audioPlayer: AudioPlayerService())
        
        await viewModel.search(term: "test")
        
        XCTAssertTrue(viewModel.songs.isEmpty)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func test_playNext_movesToNextSong() {
        let song1 = Song(id: 1, title: "Song 1", artist: "A", album: "Al", artworkURL: nil, previewURL: URL(string: "https://example.com/1.mp3"))
        let song2 = Song(id: 2, title: "Song 2", artist: "A", album: "Al", artworkURL: nil, previewURL: URL(string: "https://example.com/2.mp3"))
        
        let mockRepository = MockSongRepository()
        let useCase = SearchSongsUseCase(repository: mockRepository)
        let viewModel = SongListViewModel(searchSongsUseCase: useCase, audioPlayer: AudioPlayerService())
        viewModel.songs = [song1, song2]
        viewModel.currentSong = song1
        
        viewModel.playNext()
        
        XCTAssertEqual(viewModel.currentSong, song2)
    }
    
    func test_playNext_doesNothingWhenAtLastSong() {
        let song1 = Song(id: 1, title: "Song 1", artist: "A", album: "Al", artworkURL: nil, previewURL: URL(string: "https://example.com/1.mp3"))
        
        let mockRepository = MockSongRepository()
        let useCase = SearchSongsUseCase(repository: mockRepository)
        let viewModel = SongListViewModel(searchSongsUseCase: useCase, audioPlayer: AudioPlayerService())
        viewModel.songs = [song1]
        viewModel.currentSong = song1
        
        viewModel.playNext()
        
        XCTAssertEqual(viewModel.currentSong, song1)
    }
}

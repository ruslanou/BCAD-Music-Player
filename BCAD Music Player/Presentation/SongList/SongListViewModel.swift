import Foundation
import Combine

@MainActor
final class SongListViewModel: ObservableObject {
    @Published var songs: [Song] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var currentSong: Song? = nil
    
    let audioPlayer: AudioPlayerService
    private let searchSongsUseCase: SearchSongsUseCase
    
    init(searchSongsUseCase: SearchSongsUseCase, audioPlayer: AudioPlayerService) {
        self.searchSongsUseCase = searchSongsUseCase
        self.audioPlayer = audioPlayer
        
        self.audioPlayer.onPlaybackEnded = { [weak self] in
            self?.playNext()
        }
    }
    
    func search(term: String) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            songs = try await searchSongsUseCase.execute(term: term)
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? "Terjadi kesalahan"
        }
    }
    func selectSong(_ song: Song) {
        guard let previewURL = song.previewURL else {
            errorMessage = "Preview tidak tersedia untuk lagu ini"
            return
        }
        currentSong = song
        audioPlayer.play(url: previewURL)
    }

    func togglePlayPause() {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        } else {
            audioPlayer.resume()
        }
    }

    func playNext() {
        guard let current = currentSong,
              let index = songs.firstIndex(of: current),
              index + 1 < songs.count else { return }
        selectSong(songs[index + 1])
    }

    func playPrevious() {
        guard let current = currentSong,
              let index = songs.firstIndex(of: current),
              index - 1 >= 0 else { return }
        selectSong(songs[index - 1])
    }


}

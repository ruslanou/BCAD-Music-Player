import SwiftUI

@main
struct BCAD_Music_PlayerApp: App {
    var body: some Scene {
        WindowGroup {
            SongListView(
                viewModel: SongListViewModel(
                    searchSongsUseCase: SearchSongsUseCase(
                        repository: ITunesSongRepository(session: .shared)
                    ),
                    audioPlayer: AudioPlayerService()
                )
            )
        }
    }
}

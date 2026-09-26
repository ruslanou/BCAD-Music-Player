import SwiftUI

struct SongListView: View {
    @StateObject private var viewModel: SongListViewModel
    @State private var searchTerm: String = ""
    
    init(viewModel: SongListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.songs) { song in
                SongRowView(song: song, isPlaying: song == viewModel.currentSong)
                    .onTapGesture {
                        viewModel.selectSong(song)
                    }
            }
            .searchable(text: $searchTerm, prompt: "Search artist")
            .onSubmit(of: .search) {
                Task {
                    await viewModel.search(term: searchTerm)
                }
            }
            .navigationTitle("Music Player")
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .safeAreaInset(edge: .bottom) {
                if viewModel.currentSong != nil {
                    PlayerControlsView(viewModel: viewModel, audioPlayer: viewModel.audioPlayer)
                }
            }
            .alert("Error", isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )) {
                Button("OK") { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }

}




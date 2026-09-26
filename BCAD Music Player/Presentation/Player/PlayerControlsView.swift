import SwiftUI

struct PlayerControlsView: View {
    @ObservedObject var viewModel: SongListViewModel
    @ObservedObject var audioPlayer: AudioPlayerService
    
    var body: some View {
        VStack {
            Slider(
                value: Binding(
                    get: { audioPlayer.currentTime },
                    set: { audioPlayer.seek(to: $0) }
                ),
                in: 0...max(audioPlayer.duration, 1)
            )
            
            HStack(spacing: 40) {
                Button {
                    viewModel.playPrevious()
                } label: {
                    Image(systemName: "backward.end.fill")
                }
                
                Button {
                    viewModel.togglePlayPause()
                } label: {
                    Image(systemName: audioPlayer.isPlaying ? "pause.fill" : "play.fill")
                }
                
                Button {
                    viewModel.playNext()
                } label: {
                    Image(systemName: "forward.end.fill")
                }
            }
            .font(.title)
        }
        .padding()
    }
}

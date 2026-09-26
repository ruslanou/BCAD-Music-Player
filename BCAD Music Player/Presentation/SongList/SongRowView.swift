import SwiftUI

struct SongRowView: View {
    let song: Song
    let isPlaying: Bool
    
    var body: some View {
        HStack {
            AsyncImage(url: song.artworkURL) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(song.title)
                    .font(.headline)
                Text(song.artist)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(song.album)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            if isPlaying {
                Image(systemName: "waveform")
                    .foregroundStyle(.tint)
            }
        }
    }
}

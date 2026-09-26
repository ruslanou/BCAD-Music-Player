import Foundation

struct SongDTO: Decodable {
    let trackId: Int
    let artistName: String
    let collectionName: String?
    let trackName: String?
    let previewUrl: URL?
    let artworkUrl100: URL?
}

extension SongDTO {
    func toEntity() -> Song {
        Song(
            id: trackId,
            title: trackName ?? "Untitled",
            artist: artistName,
            album: collectionName ?? "Unknown Album",
            artworkURL: artworkUrl100,
            previewURL: previewUrl
        )
    }
}


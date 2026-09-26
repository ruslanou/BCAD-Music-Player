import Foundation

struct Song: Identifiable, Equatable {
    let id: Int
    let title, artist, album: String
    let artworkURL, previewURL: URL?
}

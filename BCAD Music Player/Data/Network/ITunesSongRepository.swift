import Foundation

struct ITunesSongRepository: SongRepository {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    private static let baseURLString = "https://itunes.apple.com"

    func searchSongs(term: String) async throws -> [Song] {
        let url = try buildSearchURL(term: term)
        let data = try await fetchData(from: url)
        
        let response = try decodeResponse(data)
        
        return mapToEntities(response.results)
    }
    
    private func buildSearchURL(term: String) throws -> URL {
        var components = URLComponents(string: Self.baseURLString)
        components?.path = "/search"
        components?.queryItems = [
            URLQueryItem(name: "term", value: term),
            URLQueryItem(name: "media", value: "music"),
            URLQueryItem(name: "entity", value: "song")
        ]
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        return url
    }
    
    private func fetchData(from url: URL) async throws -> Data {
        let data: Data
        do {
            (data, _) = try await session.data(from: url)

        } catch {
            throw NetworkError.requestFailed
        }
        return data
    }
    
    private func decodeResponse(_ data: Data) throws -> SongSearchResponse {
        let response: SongSearchResponse
        do {
            response = try JSONDecoder().decode(SongSearchResponse.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
        return response
    }
    
    private func mapToEntities(_ dtos: [SongDTO]) -> [Song] {
        dtos.map {
            $0.toEntity()
        }
    }
}

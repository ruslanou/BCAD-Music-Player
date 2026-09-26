import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case requestFailed
    case decodingFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL tidak valid"
            
        case .requestFailed:
            return "Gagal terhubung ke server. Silahkan cek koneksi internet"
            
        case .decodingFailed:
            return "Terjadi kesalahan saat memproses data"
        }
    }
}

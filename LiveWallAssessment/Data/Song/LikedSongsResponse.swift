import Foundation

struct LikedSongsResponse: Codable {
    let items: [ItemResponse]?
    let next: String?
    let offset: Int?
    let previous: String?
    let total: Int
}

struct ItemResponse: Codable {
    let track: TrackResponse
}

struct TrackResponse: Codable {
    let album: AlbumResponse?
    let artists: [ArtistResponse]?
    let duration_ms: Int?
    let id: String
    let name: String
}

struct AlbumResponse: Codable {
    let artists: [ArtistResponse]?
    let id: String?
    let images: [ImageResponse]?
}

struct ArtistResponse: Codable {
    let id, name: String
}


struct ImageResponse: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}


import Foundation

struct MediaContent: Codable, Identifiable, Hashable {
    let id = UUID()
    let contentId: Int?
    let contentName: String?
    let genre: Genre?
    let contentDescription: String?
    let contentCovertArtUrl: String?

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.contentId = try values.decode(Int.self, forKey: .contentId)
        self.contentName = try values.decode(String.self, forKey: .contentName)
        self.genre = try values.decode(Genre.self, forKey: .genre)
        self.contentDescription = try values.decode(String.self, forKey: .contentDescription)
        self.contentCovertArtUrl = try values.decode(String.self, forKey: .contentCovertArtUrl)
    }

    enum CodingKeys: String, CodingKey {
        case contentId = "content_id"
        case contentName = "content_name"
        case genre
        case contentDescription = "content_description"
        case contentCovertArtUrl = "content_cover_art_url"
    }
}

struct MasterPlaylistMetadata: Identifiable, Hashable {
    let id = UUID()
    let maxQuality: String?
    let masterPlaylistUrl: String?
}

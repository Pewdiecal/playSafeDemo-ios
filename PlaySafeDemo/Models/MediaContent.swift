import Foundation

struct MediaContent: Codable, Identifiable, Hashable {
    let id = UUID()
    let contentName: String?
    let genre: Genre?
    let licenseId: Int?
    let contentDescription: String?
    let availableRegions: CountryCode?
    let isAvailableOffline: Bool?
    let contentCovertArtUrl: String?
    let masterPlaylistURL: String?

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.contentName = try values.decode(String.self, forKey: .contentName)
        self.genre = try values.decode(Genre.self, forKey: .genre)
        self.licenseId = try values.decode(Int.self, forKey: .licenseId)
        self.contentDescription = try values.decode(String.self, forKey: .contentDescription)
        self.availableRegions = try values.decode(CountryCode.self, forKey: .availableRegions)
        let offlineAvailability = try values.decode(Int.self, forKey: .isAvailableOffline)
        self.isAvailableOffline = offlineAvailability == 1 ? true : false
        self.contentCovertArtUrl = try values.decode(String.self, forKey: .contentCovertArtUrl)
        self.masterPlaylistURL = try values.decode(String.self, forKey: .masterPlaylistURL)
    }

    enum CodingKeys: String, CodingKey {
        case contentName = "content_name"
        case genre
        case licenseId = "license_id"
        case contentDescription = "content_description"
        case availableRegions = "available_regions"
        case isAvailableOffline = "is_available_offline"
        case contentCovertArtUrl = "content_cover_art_url"
        case masterPlaylistURL = "master_playlist_url"
    }
}

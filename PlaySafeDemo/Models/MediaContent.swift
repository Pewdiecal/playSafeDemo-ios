import Foundation

struct mediaContent: Codable {
    let contentId: Int?
    let contentName: String?
    let fileFormat: String?
    let licenseId: String?
    let contentDescription: String?
    let availableRegions: CountryCode?
    let isAvailableOffline: Bool?
    let contentCovertArtUrl: String?
}

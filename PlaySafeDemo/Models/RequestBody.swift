import Foundation

struct RegisterAccountDetailsRequestBody: Codable {
    var email: String
    var username: String
    var password: String
    var registeredRegion: CountryCode
    var maxStreamingQuality: StreamingResolution
}

struct LoginRequestBody: Codable {
    var username: String
    var password: String
}

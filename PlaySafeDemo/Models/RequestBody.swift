import Foundation

struct RegisterAccountDetailsRequestBody: Codable {
    var email: String
    var username: String
    var password: String
    var registeredRegion: CountryCode
    var subscriptionType: SubscribtionType
    var isContentProvider: Bool = false
}

struct LoginRequestBody: Codable {
    var username: String
    var password: String
}

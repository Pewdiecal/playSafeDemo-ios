import Foundation

struct User: Codable {
    let userId: Int?
    let accoundId: Int?
    let username: String?
    let email: String?
    let password: String?
    let isContentProvider: Bool?
}

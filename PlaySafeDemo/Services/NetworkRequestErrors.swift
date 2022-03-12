import Foundation

/// App network request errors
enum NetworkRequestError: Error {
    // App determined error
    case dataSerialization(reason: String?)
    case urlError
    case requestToServerFailed
    case notConnectedToInternet
    case invalidData

    // HTTP Status Code 400 range
    case badRequest
    case notFound
    case unauthorized

    case missingRequiredField

    // HTTP Status code 500 range
    case internalServerError

    case limitExceeded
}

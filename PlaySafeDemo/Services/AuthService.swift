import Foundation
import Combine

struct Token: Decodable {
    let accessToken: String
}

class AuthService {
    func fetchAccessToken(username: String, password: String) -> AnyPublisher<Token, Error>{
        var request = URLRequest(url: NetworkRequestService.baseUrl!.appendingPathComponent("/login"))
        request.httpMethod = URLRequest.HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(username, forHTTPHeaderField: "username")
        request.setValue(password, forHTTPHeaderField: "password")

        return urlSession.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpURLResponse = response as? HTTPURLResponse,
                      (200 ... 299).contains(httpURLResponse.statusCode)
                else {
                    throw self.handleResponseFailure(data: data, response: response)
                }

                return data
            }
            .decode(type: Token.self, decoder: JSONDecoder())
            .map { token in
                self.accessToken = token
                return token
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func handleResponseFailure(
        data: Data?,
        response: URLResponse
    ) -> NetworkRequestError {
        var error = NetworkRequestError.badRequest

        if let response = response as? HTTPURLResponse {
            switch response.statusCode {
            case 401:
                error = NetworkRequestError.unauthorized

            case 404:
                error = NetworkRequestError.notFound

            default:
                break
            }
        }

        return error
    }

    private let urlSession = URLSession.shared
    var accessToken: Token?
}

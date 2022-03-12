import Foundation
import Combine

class RegisterAccountViewModel: ObservableObject {
    init() {
        self.networkRequestService = NetworkRequestService()
    }

    private func registerAccount(email: String,
                                 username: String,
                                 password: String,
                                 confirmPassword: String,
                                 countryCode: CountryCode) {
        let requestBody = RegisterAccountDetailsRequestBody(email: email,
                                                            username: username,
                                                            password: password,
                                                            registeredRegion: countryCode,
                                                            maxStreamingQuality: .fullHD_1080)

        do {
            let data = try JSONEncoder().encode(requestBody)
            self.networkRequestService.apiRequest(.post, "/register", requestBody: data, queryItems: nil)
                .sink { [weak self] completion in
                    guard let strongSelf = self else {
                        return
                    }
                    switch completion {
                    case .failure(let error):
                        strongSelf.errorMessage = error.localizedDescription
                    case .finished:
                        trace("Registration Success")
                    }
                } receiveValue: { [weak self] (data: Data, httpResponseCode: Int) in
                    guard let strongSelf = self else {
                        return
                    }
                    if (200 ... 299).contains(httpResponseCode) {
                        strongSelf.isSuccess = true
                    } else {
                        strongSelf.errorMessage = "Alert: Bad response code \(httpResponseCode)."
                    }
                }
                .store(in: &cancelleble)
        } catch {
            trace("\(error)")
        }
    }

    private var networkRequestService: NetworkRequestService
    private var cancelleble: Set<AnyCancellable> = Set()
    @Published var errorMessage: String? = nil
    @Published var isSuccess: Bool = false
}

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    init() {
        self.authService = AuthService()
    }

    func login(username: String, password: String) {
        authService.fetchAccessToken(username: username, password: password)
            .sink { _ in

            } receiveValue: { [weak self] token in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.networkRequestService = NetworkRequestService(authService: strongSelf.authService)
            }
            .store(in: &cancelleble)
    }

    private let authService: AuthService
    private var cancelleble: Set<AnyCancellable> = Set()
    @Published var networkRequestService: NetworkRequestService? = nil
}

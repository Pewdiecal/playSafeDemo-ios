import Foundation
import Combine

class HomeViewModel: ObservableObject {
    init(networkRequestService: NetworkRequestService) {
        self.networkRequestService = networkRequestService
        self.authService = networkRequestService.authService!
    }

    func fetchAllMediaContent() {
        networkRequestService.apiRequest(.get, "/api/media/getContentList/\(authService.user!.registeredRegion.rawValue)",
                                         requestBody: nil,
                                         queryItems: nil)
            .map { (data, Int) in
                return data
            }
            .decode(type: [MediaContent].self, decoder: JSONDecoder())
            .mapError { error -> NetworkRequestError in
                trace("Decoding error: \(error.localizedDescription)")
                return NetworkRequestError.dataSerialization(reason: error.localizedDescription)
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    trace("getContentList API request error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] mediaContents in
                guard let strongSelf = self else {
                    return
                }

                for genre in Genre.allCases {
                    switch genre {
                    case .comedy:
                        strongSelf.comedyContent = mediaContents.filter{ mediaContent in
                            return mediaContent.genre == genre
                        }
                    case .kpop:
                        strongSelf.kpopContent = mediaContents.filter { mediaContent in
                            return mediaContent.genre == genre
                        }
                    case .horror:
                        strongSelf.horrorContent = mediaContents.filter{ mediaContent in
                            return mediaContent.genre == genre
                        }
                    case .relaxing:
                        strongSelf.relaxingContent = mediaContents.filter{ mediaContent in
                            return mediaContent.genre == genre
                        }
                    case .sci_fi:
                        strongSelf.sciFiContent = mediaContents.filter{ mediaContent in
                            return mediaContent.genre == genre
                        }
                    case .drama:
                        strongSelf.dramaContent = mediaContents.filter { mediaContent in
                            return mediaContent.genre == genre
                        }
                    }
                }
            }
            .store(in: &cancelleble)
    }

    func logout() {
        networkRequestService.apiRequest(.post, "/api/auth/logout", requestBody: nil, queryItems: nil)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    trace("getContentList API request error: \(error.localizedDescription)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] _ in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.logoutSuccess = true
            }
            .store(in: &cancelleble)
    }

    func getContentBasedOnGenre(genre: Genre) -> [MediaContent] {
        switch genre {
        case .comedy:
            return self.comedyContent
        case .kpop:
            return self.kpopContent
        case .horror:
            return self.horrorContent
        case .relaxing:
            return self.relaxingContent
        case .sci_fi:
            return self.sciFiContent
        case .drama:
            return self.dramaContent
        }
    }

    private let networkRequestService: NetworkRequestService
    private let authService: AuthService
    private var cancelleble: Set<AnyCancellable> = Set()
    @Published var errorMessage: String?
    @Published var comedyContent: [MediaContent] = []
    @Published var kpopContent: [MediaContent] = []
    @Published var horrorContent: [MediaContent] = []
    @Published var relaxingContent: [MediaContent] = []
    @Published var sciFiContent: [MediaContent] = []
    @Published var dramaContent: [MediaContent] = []
    @Published var showingAlert = false
    @Published var logoutSuccess = false
}

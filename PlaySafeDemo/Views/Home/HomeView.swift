import SwiftUI
import AVFoundation
import AVKit

struct HomeView: View {
    var networkRequestService: NetworkRequestService
    @StateObject var homeViewModel: HomeViewModel
    @State var mediaContents: MediaContent?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isLoading = false

    init(networkRequestService: NetworkRequestService) {
        self.networkRequestService = networkRequestService
        self._homeViewModel = StateObject(wrappedValue: HomeViewModel(networkRequestService: networkRequestService))

    }

    var rows: [GridItem] = [
        GridItem(.flexible(minimum: 300), spacing: 16)
        ]

    var body: some View {
        VStack {
            ScrollView {
                ForEach(Genre.allCases, id: \.self) { genre in
                    Section(header: HStack {
                        Text(genre.rawValue).font(.title)
                        Spacer()
                    }) {
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows,
                                      spacing: 10) {
                                ForEach(homeViewModel.getContentBasedOnGenre(genre: genre), id: \.self) { mediaContent in
                                    Button {
                                        mediaContents = mediaContent
                                    } label: {
                                        MediaCatalogueCellView(imageUrl: "http://192.168.1.214:8000\(mediaContent.contentCovertArtUrl!)",
                                                               title: mediaContent.contentName!, genre: mediaContent.genre!.rawValue)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.leading, 12)
                        }
                    }
                }
            }
            .refreshable(action: {
                homeViewModel.fetchAllMediaContent()
            })
            .padding(.leading, 10)
            Spacer()
            NavigationLink("", destination: LoginView(), isActive: $homeViewModel.logoutSuccess)
        }
        .onReceive(homeViewModel.$logoutSuccess) { isSuccess in
            if isSuccess {
                self.presentationMode.wrappedValue.dismiss()
            }
            isLoading = false
        }
        .onAppear(perform: homeViewModel.fetchAllMediaContent)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Home")
        .toolbar {
            Button("Logout") {
                isLoading = true
                homeViewModel.logout()
            }
        }
        .fullScreenCover(item: $mediaContents) {
          // On Dismiss Closure
        } content: { item in
            makeFullScreenVideoPlayer(for: "http://192.168.1.214:8000\(item.masterPlaylistURL!)")
        }
        .overlay(ProgressView("Logging out ...")
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 10)
            .opacity(isLoading ? 1 : 0))
    }

    @ViewBuilder
    private func makeFullScreenVideoPlayer(for videoUrl: String) -> some View {
        let videoAsset = AVURLAsset(url: URL(string: videoUrl)!)
        let playerItem = AVPlayerItem(asset: videoAsset)
        let avPlayer = AVPlayer(playerItem: playerItem)
        VideoPlayer(player: avPlayer)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                avPlayer.play()
            }
    }
}

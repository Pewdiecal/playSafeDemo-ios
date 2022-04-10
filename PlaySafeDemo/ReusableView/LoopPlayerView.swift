import SwiftUI
import AVKit

struct LoopingPlayerView: UIViewRepresentable {
  let videoURLs: [URL]


  func updateUIView(_ uiView: LoopingPlayerUIView, context: Context) {
  }

  func makeUIView(context: Context) -> LoopingPlayerUIView {
    let view = LoopingPlayerUIView(urls: videoURLs)
    return view
  }
}

final class LoopingPlayerUIView: UIView {
  private var player: AVQueuePlayer?
  private var token: NSKeyValueObservation?

  private var allURLs: [URL]

  var playerLayer: AVPlayerLayer {
    // swiftlint:disable:next force_cast
    layer as! AVPlayerLayer
  }

  override class var layerClass: AnyClass {
    return AVPlayerLayer.self
  }

  init(urls: [URL]) {
      allURLs = urls
      player = AVQueuePlayer()

      super.init(frame: .zero)

      addAllVideosToPlayer()

      player?.volume = 0.0
      player?.play()

      playerLayer.player = player

      token = player?.observe(\.currentItem) { [weak self] player, _ in
          if player.items().count == 1 {
              self?.addAllVideosToPlayer()
          }
      }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func addAllVideosToPlayer() {
    for url in allURLs {
      let asset = AVURLAsset(url: url)
      let item = AVPlayerItem(asset: asset)
      player?.insert(item, after: player?.items().last)
    }
  }
}

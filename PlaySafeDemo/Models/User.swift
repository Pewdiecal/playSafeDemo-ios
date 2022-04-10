import Foundation

struct User: Codable {
    let registeredRegion: CountryCode
    let maxStreamingQuality: StreamingResolution
    let subscribtionStatus: SubscribtionStatus
    let downloadedContentQty: Int
    let totalStreamingHours: Float
    let loggedInDeviceNum: Int

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        self.registeredRegion = try values.decode(CountryCode.self, forKey: .registeredRegion)
        self.maxStreamingQuality = try values.decode(StreamingResolution.self, forKey: .maxStreamingQuality)
        self.subscribtionStatus = try values.decode(SubscribtionStatus.self, forKey: .subscribtionStatus)
        self.downloadedContentQty = try values.decode(Int.self, forKey: .downloadedContentQty)
        self.totalStreamingHours = try values.decode(Float.self, forKey: .totalStreamingHours)
        self.loggedInDeviceNum = try values.decode(Int.self, forKey: .loggedInDeviceNum)
    }

    enum CodingKeys: String, CodingKey {
        case registeredRegion = "registered_region"
        case maxStreamingQuality = "max_streaming_quality"
        case subscribtionStatus = "subscribtion_status"
        case downloadedContentQty = "downloaded_content_qty"
        case totalStreamingHours = "total_streaming_hours"
        case loggedInDeviceNum = "loggedIn_device_num"
    }
}

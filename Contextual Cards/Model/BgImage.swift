import Foundation

struct BgImage: Codable {
    let imageType: String
    let imageURL: String?
    let webpImageURL: String?
    let aspectRatio: Double
    let assetType: String?
    
    enum CodingKeys: String, CodingKey {
        case imageType = "image_type"
        case imageURL = "image_url"
        case webpImageURL = "webp_image_url"
        case aspectRatio = "aspect_ratio"
        case assetType = "asset_type"
    }
    
    static let shared = BgImage(imageType: "ext", imageURL: "https://westeros.r2.famapp.xyz/media/images/generic/ea55b045400042b1955a9a20201ffacb.png", webpImageURL: "https://westeros.r2.famapp.xyz/media/images/generic/ea55b045400042b1955a9a20201ffacb.png.webp", aspectRatio: 0.9142857, assetType: nil)
}

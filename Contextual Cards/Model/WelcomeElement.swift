import Foundation

struct WelcomeElement: Codable {
    let id: Int
    let slug: String
    let title: String? // null in given data
    let formattedTitle: Formatted? // null in given data
    let description: String? // null in given data
    let formattedDescription: Formatted? // null in given data
    let assets: String? // null in given data
    let hcGroups: [HcGroup]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case slug = "slug"
        case title = "title"
        case formattedTitle = "formatted_title"
        case description = "description"
        case formattedDescription = "formatted_description"
        case assets = "assets"
        case hcGroups = "hc_groups"
    }
}

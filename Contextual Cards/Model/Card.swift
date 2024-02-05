import Foundation

struct Card: Codable, Hashable {
    
    let id: Int
    let name: String
    let slug: String
    let title: String?
    let formattedTitle: Formatted?
    let positionalImages: [String] //data type is unknown
    let components: [String] //data type is unknown
    let url: String?
    let bgImage: BgImage?
    let cta: [Cta]?
    let isDisabled: Bool
    let isShareable: Bool
    let isInternal: Bool
    let icon: BgImage?
    let bgColor: String?
    let iconSize: Int?
    let bgGradient: BgGradient?
    let description: String?
    let formattedDescription: Formatted?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case slug = "slug"
        case title = "title"
        case formattedTitle = "formatted_title"
        case positionalImages = "positional_images"
        case components = "components"
        case url = "url"
        case bgImage = "bg_image"
        case cta = "cta"
        case isDisabled = "is_disabled"
        case isShareable = "is_shareable"
        case isInternal = "is_internal"
        case icon = "icon"
        case bgColor = "bg_color"
        case iconSize = "icon_size"
        case bgGradient = "bg_gradient"
        case description = "description"
        case formattedDescription = "formatted_description"
    }
    
    static let shared = Card(id: 2, name: "Test hcc", slug: "Testhccwithaction", title: "Big display card\nwith action\nThis is a sample text for the subtitle that you can add to contextual cards", formattedTitle: Formatted.shared, positionalImages: [], components: [], url: "fp://fampay.in/pay/", bgImage: BgImage.shared, cta: [Cta.shared], isDisabled: false, isShareable: false, isInternal: false, icon: nil, bgColor: nil, iconSize: nil, bgGradient: nil, description: nil, formattedDescription: nil)
    
}

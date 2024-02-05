import Foundation

struct HcGroup: Codable {
    let id: Int
    let name: String
    let designType: DesignType
    let cardType: Int
    let cards: [Card]
    let isScrollable: Bool
    let height: Int?
    let isFullWidth: Bool
    let slug: String?
    let level: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case designType = "design_type"
        case cardType = "card_type"
        case cards = "cards"
        case isScrollable = "is_scrollable"
        case height = "height"
        case isFullWidth = "is_full_width"
        case slug = "slug"
        case level = "level"
    }
}

public enum DesignType: String, Codable {
    case smallDisplayCard = "HC1"
    case bigDisplayCard = "HC3"
    case imageCard = "HC5"
    case smallCardWithArrow = "HC6"
    case dynamicWidthCard = "HC9"
}


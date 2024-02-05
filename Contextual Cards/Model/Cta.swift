import Foundation

struct Cta: Codable {
    let text: String
    let type: String
    let bgColor: String?
    let url: String?
    let isCircular: Bool
    let isSecondary: Bool
    let strokeWidth: Int
    let textColor: String?
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case type = "type"
        case bgColor = "bg_color"
        case url = "url"
        case isCircular = "is_circular"
        case isSecondary = "is_secondary"
        case strokeWidth = "stroke_width"
        case textColor = "text_color"
    }
    
    static let shared = Cta(text: "Action", type: "normal", bgColor: "#000000", url: nil, isCircular: false, isSecondary: false, strokeWidth: 0, textColor: nil)
}

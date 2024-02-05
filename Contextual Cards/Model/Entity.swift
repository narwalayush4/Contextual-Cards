import Foundation

struct Entity: Codable, Hashable {
    
    let text: String?
    let type: EntityType
    let color: String?
    let fontStyle: String?
    let fontFamily: String?
    let fontSize: Int?
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case type = "type"
        case color = "color"
        case fontStyle = "font_style"
        case fontFamily = "font_family"
        case fontSize = "font_size"
    }
    
    static let shared = Entity(text: "Big display card", type: .genericText, color: "#FBAF03", fontStyle: "underline", fontFamily: "met_semi_bold", fontSize: 30)
}

public enum EntityType: String, Codable {
    case genericText = "generic_text"
    case username = "username"
    case fullname = "fullname"
}

import Foundation

struct Formatted: Codable {
    let text: String
    let align: String
    let entities: [Entity]
    
    static let shared = Formatted(text: "Big display card", align: "center", entities: [Entity.shared])
}

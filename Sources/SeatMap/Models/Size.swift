import Foundation

struct Size: Codable, Equatable {
    let width: Int
    let height: Int
    
    enum CodingKeys: String, CodingKey {
        // For now, these values are coming only for landscape UI.
        // As we need to display in portrait mode, we switch the values here.
        case width = "height"
        case height = "width"
    }
}

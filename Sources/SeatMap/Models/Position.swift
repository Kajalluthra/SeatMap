import Foundation

struct Position: Codable, Equatable, Hashable {
    
    let x: Int
    let y: Int
    let width: Int?
    let height: Int?
    
    enum CodingKeys: String, CodingKey {
        // The coordinates are for landscape orientation. We switch the values to get the
        // portrait orientation
        case x = "y"
        case y = "x"
        case width = "height"
        case height = "width"
    }
}

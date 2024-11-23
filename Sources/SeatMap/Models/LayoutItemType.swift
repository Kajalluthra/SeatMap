import Foundation

public enum LayoutItemType: String, Codable, Equatable, Hashable {
    case luggageRoom = "LuggageRoom"
    case luggageRack = "LuggageRack"
    case table = "Table"
    case bathroom = "Bathroom"
    case babyChangeBathroom = "BabyChangeBathroom"
    case accessibleBabyChangeBathroom = "AccessibleBabyChangeBathroom"
    case accessibleBathroom = "AccessibleBathroom"
    case stairs = "Stairs"
    case other = "Other"
    case exit = "Exit"
    case exitRight = "ExitRight"
    case buffet = "Buffet"
    case wall = "Wall"
    case unknown = "Unknown"
    
    var imageName: String {
        switch self {
        case .other, .unknown:
            return "EmptyTile"
        case .luggageRack, .luggageRoom:
            return "Luggage"
        case .bathroom, .babyChangeBathroom:
            return "Bathroom"
        case .accessibleBabyChangeBathroom, .accessibleBathroom:
            return "AccessibleBathroom"
        case .exit:
            return "ExitLeft"
        case .stairs:
            return "StairsBoth"
        default:
            return rawValue
        }
    }
}

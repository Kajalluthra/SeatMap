import Foundation

public enum TravelDirection: String, Codable, Equatable {
    case left = "Left"
    case right = "Right"
    
    var portraitValue: String {
        switch self {
        case .right:
            return "Up"
        case .left:
            return "Down"
        }
    }
}

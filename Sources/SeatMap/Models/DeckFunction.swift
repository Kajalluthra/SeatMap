import Foundation

public enum DeckFunction: String, Codable, Equatable {
    case Passenger
    case Bar
    case Dining
    case Unspecified
    
    func getImageName(isSingleCoach: Bool) -> String {
        let coachNumberText = isSingleCoach ? "SingleCoach" : "DoubleCoach"
        switch self {
        case .Passenger, .Unspecified:
            return coachNumberText + "Bar"
        default:
            return coachNumberText + self.rawValue
        }
    }
}

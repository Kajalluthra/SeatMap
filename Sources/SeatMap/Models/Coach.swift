import Foundation

public struct Coach: Codable, Equatable {
    let id: String
    let seatSelectionAvailable: Bool
    let decks: [Deck]
}

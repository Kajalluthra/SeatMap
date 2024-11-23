import Foundation

public struct Deck: Codable, Equatable {
    let numAvailableSeats: Int
    let cacheId: String
    let floorPlanSize: Size?
    let defaultSeatSize: Size?
    let function: DeckFunction
    let seats: [Seat]
    let layoutItems: [LayoutItem]
}

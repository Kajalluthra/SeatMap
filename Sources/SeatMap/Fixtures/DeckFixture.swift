import Foundation

extension Deck {
    static func fixture(numAvailableSeats: Int = 1,
                        cacheId: String = "",
                        floorPlanSize: Size = Size(width: 0, height: 0),
                        defaultSeatSize: Size = Size(width: 0, height: 0),
                        function: DeckFunction = .Passenger,
                        seats: [Seat] = [],
                        layoutItems: [LayoutItem] = []) -> Deck {
        Deck(numAvailableSeats: numAvailableSeats,
             cacheId: cacheId,
             floorPlanSize: floorPlanSize,
             defaultSeatSize: defaultSeatSize,
             function: function,
             seats: seats,
             layoutItems: layoutItems)
    }
}

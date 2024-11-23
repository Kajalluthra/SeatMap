import Foundation

public struct Vehicle: Codable, Equatable {
    let id: String
    let travelDirection: TravelDirection
    let coaches: [Coach]
    let changesDirectionOnRoute: Bool
    var isDouble: Bool {
        return coaches.contains(where: { $0.decks.count == 2 })
    }
    public var hasSeats: Bool {
        return coaches.contains(where: { $0.decks.contains(where: { !$0.seats.isEmpty }) })
    }

    public init(id: String, 
                travelDirection: TravelDirection,
                coaches: [Coach],
                changesDirectionOnRoute: Bool) {
        self.id = id
        self.travelDirection = travelDirection
        self.coaches = coaches
        self.changesDirectionOnRoute = changesDirectionOnRoute
    }
}

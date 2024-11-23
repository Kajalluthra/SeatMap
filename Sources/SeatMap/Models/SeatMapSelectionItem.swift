import Foundation

public struct SeatMapSelectionItem: Equatable {
    
    public var travelSegmentId: String
    public var seatReservationSelected: Bool
    public var savedCoachName: String
    public var savedSeatNumber: String

    public init(travelSegmentId: String, seatReservationSelected: Bool = false, savedCoachName: String = "", savedSeatNumber: String = "") {
        self.travelSegmentId = travelSegmentId
        self.seatReservationSelected = seatReservationSelected
        self.savedCoachName = savedCoachName
        self.savedSeatNumber = savedSeatNumber
    }
}

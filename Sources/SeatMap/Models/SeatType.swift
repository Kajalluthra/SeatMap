import Foundation

enum SeatType: String, Codable, Equatable {
    case priority = "Priority"
    case seat = "Seat"
    case wheelchair = "Wheelchair"
    case wheelchairCompanion = "WheelchairCompanion"
    case bike = "Bike"
}

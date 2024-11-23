import Foundation

public struct Seat: Codable, Equatable {
    let id: String
    var status: SeatStatus
    let inventoryCode: String?
    let direction: TravelDirection
    let type: SeatType
    let position: Position
}

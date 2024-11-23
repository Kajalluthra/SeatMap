import Foundation

public struct SeatMapResponse: Codable {
    
    public let vehicle: Vehicle
    
    public init(vehicle: Vehicle) {
        self.vehicle = vehicle
    }
}

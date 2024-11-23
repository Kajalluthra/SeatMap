import Foundation
import Networking

public protocol SeatMapServiceProtocol {
    func getSeatMap(seatMapInformation: SeatMapInformation) async -> Result<SeatMapResponse, RequestError>
}

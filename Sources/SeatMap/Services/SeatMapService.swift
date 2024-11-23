import Foundation
import Networking
import os
import LoggerExtension

public struct SeatMapService: HTTPClient, SeatMapServiceProtocol {
    public var session: URLSession
    
    public init(_ urlSession: URLSession = .shared) {
        self.session = urlSession
    }
    
    public func getSeatMap(seatMapInformation: SeatMapInformation) async -> Result<SeatMapResponse, RequestError> {
        let seatMapRequest = SeatMapRequest(keyAccessible: seatMapInformation.seatMapAPIKeyAccessible,
                                            externalSupplier: seatMapInformation.externalSupplier,
                                            carrier: seatMapInformation.carrier,
                                            vehicleId: seatMapInformation.vehicleID,
                                            boardLocation: seatMapInformation.boardLocation,
                                            alightLocation: seatMapInformation.alightLocation,
                                            departureDateTime: seatMapInformation.departureDateTime,
                                            ticketClass: seatMapInformation.ticketClass,
                                            inventoryCode: seatMapInformation.inventoryCode,
                                            context: Config.shoppingContext
        )
        Logger.service.log(level: .info, message: "called with params: \(seatMapRequest.getParamsDictionary())")
        let result = await self.sendGetRequest(endpoint: SeatMapGetEndpoints.seatMapTransactionalV2(seatMapRequest: seatMapRequest), responseModel: SeatMapResponse.self)
        switch result {
        case .success(let successResponse):
            return .success(successResponse.data)
        case .failure(let error):
            return .failure(error)
        }
    }
}

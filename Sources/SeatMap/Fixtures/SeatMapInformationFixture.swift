import Foundation

public extension SeatMapInformation {
    static func fixture(seatMapAPIKeyAccessible: Bool = true,
                        externalProposal: String? = "",
                        externalTravelSegment: String? = "",
                        externalSupplier: String = "",
                        carrier: String = "",
                        externalSearchToken: String? = "",
                        vehicleID: String = "",
                        boardLocation: String = "",
                        alightLocation: String = "",
                        departureDateTime: String = "",
                        ticketClass: String = "",
                        inventoryCode: String = "") -> SeatMapInformation {
        SeatMapInformation(seatMapAPIKeyAccessible: seatMapAPIKeyAccessible,
                           externalProposal: externalProposal,
                           externalTravelSegment: externalTravelSegment,
                           externalSupplier: externalSupplier,
                           carrier: carrier,
                           externalSearchToken: externalSearchToken,
                           vehicleID: vehicleID,
                           boardLocation: boardLocation,
                           alightLocation: alightLocation,
                           departureDateTime: departureDateTime,
                           ticketClass: ticketClass,
                           inventoryCode: inventoryCode)
    }
}

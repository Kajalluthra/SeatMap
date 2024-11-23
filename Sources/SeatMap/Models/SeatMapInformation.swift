import Foundation

public struct SeatMapInformation: Codable, Equatable {
    let seatMapAPIKeyAccessible: Bool
    let externalProposal: String?
    let externalTravelSegment: String?
    let externalSupplier: String
    let carrier: String
    let externalSearchToken: String?
    let vehicleID: String
    let boardLocation: String
    let alightLocation: String
    let departureDateTime: String
    let ticketClass: String?
    let inventoryCode: String?

    enum CodingKeys: String, CodingKey {
        case seatMapAPIKeyAccessible = "SeatMapAPIKeyAccessible"
        case externalProposal = "ExternalProposal"
        case externalTravelSegment = "ExternalTravelSegment"
        case externalSupplier = "ExternalSupplier"
        case carrier = "Carrier"
        case externalSearchToken = "ExternalSearchToken"
        case vehicleID = "VehicleId"
        case boardLocation = "BoardLocation"
        case alightLocation = "AlightLocation"
        case departureDateTime = "DepartureDateTime"
        case ticketClass = "TicketClass"
        case inventoryCode = "InventoryCode"
    }
}

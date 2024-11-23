import Foundation
import Networking

public struct SeatMapRequest: QueryParameterizable {
    @QueryParam("SeatMapAPIKeyAccessible") var keyAccessible: Bool?
    @QueryParam("ExternalSupplier") var externalSupplier: String?
    @QueryParam("Carrier") var carrier: String?
    @QueryParam("VehicleId") var vehicleId: String?
    @QueryParam("BoardLocation") var boardLocation: String?
    @QueryParam("AlightLocation") var alightLocation: String?
    @QueryParam("DepartureDateTime") var departureDateTime: String?
    @QueryParam("TicketClass") var ticketClass: String?
    @QueryParam("InventoryCode") var inventoryCode: String?
    @QueryParam("LanguageCode") var languageCode: String?
    @QueryParam("context") var context: String?
    
    init(keyAccessible: Bool? = nil,
         externalSupplier: String? = nil,
         carrier: String? = nil,
         vehicleId: String? = nil,
         boardLocation: String? = nil,
         alightLocation: String? = nil,
         departureDateTime: String? = nil,
         ticketClass: String? = nil,
         inventoryCode: String? = nil,
         languageCode: String? = "en",
         context: String? = nil) {
        self.keyAccessible = keyAccessible
        self.externalSupplier = externalSupplier
        self.carrier = carrier
        self.vehicleId = vehicleId
        self.boardLocation = boardLocation
        self.alightLocation = alightLocation
        self.departureDateTime = departureDateTime
        self.ticketClass = ticketClass
        self.inventoryCode = inventoryCode
        self.languageCode = languageCode
        self.context = context
    }
}

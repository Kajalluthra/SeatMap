import XCTest
@testable import SeatMap
@testable import Networking
@testable import TestUtils

class SeatMapServiceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        SeatMap.setup(with: ConfigMock.self)
        Networking.setup(with: ConfigMock.self)
    }
    
    func testWhenGetSeatMapIsCalledWithCorrectInformationShouldReturnCorrectResult() async throws {
        let service = SeatMapService(urlSession)
        self.configureMockResponse(with: Bundle.module, jsonFilename: "SeatMapResponseCorrect", statusCode: 200)
        let result = await service.getSeatMap(seatMapInformation: .fixture())
        switch result {
        case .success(let seatMap):
            let coaches = seatMap.vehicle.coaches
            XCTAssertEqual(coaches.count, 5)
            XCTAssertEqual(coaches.first?.decks.count, 1)
            XCTAssertFalse(coaches.first?.decks.first?.seats.isEmpty ?? false)
        case .failure:
            XCTFail("The request should not fail")
        }
    }
    
    func testWhenGetSeatMapIsCalledWithIncorrectCredentialsItShouldReturnUnauthorizedError() async throws {
        let service = SeatMapService(urlSession)
        self.configureMockResponse(jsonFilename: "Response401Error", statusCode: 200)
        let result = await service.getSeatMap(seatMapInformation: .fixture())
        switch result {
        case .success:
            XCTFail("The request should return an error")
        case .failure(let error):
            XCTAssertEqual(error, RequestError.unauthorized)
        }
    }
}

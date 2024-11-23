import Foundation
import Networking
import Core

public enum SeatMapGetEndpoints {
    case seatMapTransactionalV2(seatMapRequest: SeatMapRequest)
}

extension SeatMapGetEndpoints: GetEndpoint {

    public var header: [String : String] {
        get async {
            switch self {
            case .seatMapTransactionalV2:
                return await getHeaders(auth: true, contentType: .json)
            }
        }
    }
    public var path: String { 
        switch self {
        case .seatMapTransactionalV2:
            return "seatmap/transactional/v2"
        }
    }
    
    
    public var queryParameters: String? {
        var components = URLComponents()
        switch self {
        case .seatMapTransactionalV2(let seatMapRequest):
            components.setQueryItems(with: seatMapRequest.getParamsDictionary())
        }
        return components.url?.absoluteString
    }
    
    
}

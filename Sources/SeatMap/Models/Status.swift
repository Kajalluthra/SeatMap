import SwiftUI
import UIComponents

enum SeatStatus: String, Codable, Equatable {
    case free = "FREE"
    case restricted = "RESTRICTED"
    case selected
    
    var statusName: String {
        switch self {
        case .free:
            return "Available"
        case .selected:
            return "Selected"
        case .restricted:
            return "Unavailable"
        }
    }
    
    var legendText: String {
        switch self {
        case .free:
            return "available.text".localized
        case .restricted:
            return "unavailable.text".localized
        case .selected:
            return "selected.text".localized
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .free, .restricted:
            return ThemePalette.seatMaps.floor.neutral
        case .selected:
            return .white
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .free:
            return ThemePalette.seatMaps.optionItems.primaryIconDefault
        case .restricted:
            return ThemePalette.seatMaps.optionItems.primaryIconUnavailable
        case .selected:
            return ThemePalette.seatMaps.optionItems.primaryIconSelected
        }
    }
    
    var strokeColor: Color {
        switch self {
        case .selected:
            return ThemePalette.seatMaps.optionItems.strokeSelected
        default:
            return .clear
        }
    }
}

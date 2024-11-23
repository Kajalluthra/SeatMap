import Foundation

public struct LayoutItem: Codable, Equatable, Hashable {
    let type: LayoutItemType
    let position: Position
}

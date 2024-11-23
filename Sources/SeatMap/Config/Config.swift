import Foundation

public protocol SeatMapConfig {
    static var shoppingContext: String { get }
}

public func setup(with config: SeatMapConfig.Type) {
    ConfigType.shared = ConfigType(config)
}

var Config: ConfigType { // swiftlint:disable:this variable_name
    if let config = ConfigType.shared {
        return config
    } else {
        fatalError("Please set the Config for \(Bundle(for: ConfigType.self))")
    }
}

final class ConfigType {
    
    static fileprivate var shared: ConfigType?
    
    let shoppingContext: String
    
    fileprivate init(_ config: SeatMapConfig.Type) {
        self.shoppingContext = config.shoppingContext
    }
}

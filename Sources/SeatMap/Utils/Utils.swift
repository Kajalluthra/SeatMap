import Foundation

struct Utils {
    static func loadJSON(name: String) -> Data {
        guard let path = Bundle.module.url(forResource: name, withExtension: "json") else {
            return Data()
        }
        do {
            let data = try Data(contentsOf: path)
            return data
        } catch {
            return Data()
        }
    }
}

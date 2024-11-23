import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, bundle: Bundle.module, comment: " ")
    }
}

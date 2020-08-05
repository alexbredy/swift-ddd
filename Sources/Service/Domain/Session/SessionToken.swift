import Foundation


struct SessionToken: Hashable {
    let value: String

    init(_ value: String) {
        self.value = value
    }
}

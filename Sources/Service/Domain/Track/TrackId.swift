import Foundation


struct TrackId: Hashable {
    let value: UUID

    var description: String {
        return value.uuidString
    }

    init(_ value: UUID = UUID()) {
        self.value = value
    }

    init(_ value: String) {
        self.value = UUID(uuidString: value)!
    }
}

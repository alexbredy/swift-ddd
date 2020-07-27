import Foundation


struct TrackTitle {
    private static let minLength = 1
    private static let maxLength = 128

    let value: String

    init(_ value: String) throws {
        guard TrackTitle.minLength...TrackTitle.maxLength ~= value.count else {
            throw DomainError(
                code: .invalidTrackName,
                message: "The track name must be between \(TrackTitle.minLength) and \(TrackTitle.maxLength) characters"
            )
        }

        self.value = value
    }
}

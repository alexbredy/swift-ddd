import Foundation


struct TrackComment {
    private static let minLength = 1
    private static let maxLength = 1024

    let value: String

    init(_ value: String) throws {
        guard TrackComment.minLength...TrackComment.maxLength ~= value.count else {
            throw DomainError(
                code: .invalidTrackComment,
                message: "The track comment must be between \(TrackComment.minLength) and \(TrackComment.maxLength) characters"
            )
        }

        self.value = value
    }
}

import Foundation


struct TrackScore {
    private static let min = 0
    private static let max = 10

    let value: Int

    init(_ value: Int) throws {
        guard TrackScore.min...TrackScore.max ~= value else {
            throw DomainError(
                code: .invalidTrackScore,
                message: "The track score must be between \(TrackScore.min) and \(TrackScore.max)"
            )
        }

        self.value = value
    }
}

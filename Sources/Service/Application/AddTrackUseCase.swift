import Foundation


struct AddTrackUseCase {

    private let trackRepository: TrackRepository

    func execute<T>(transformer: (Track) -> T) throws -> T {
        let track = Track(
            id: TrackId(),
            ownedBy: ProfileId(),
            title: try TrackTitle("Still More Fighting"),
            comment: try TrackComment("Best boss battle"),
            score: try TrackScore(10),
            createdOn: Date()
        )

        let savedTrack = try trackRepository.save(track)

        return transformer(savedTrack)
    }
}

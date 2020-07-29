import Foundation
import Interface


struct AddTrackUseCase {

    private let trackRepository: TrackRepository

    init(trackRepository: TrackRepository) {
        self.trackRepository = trackRepository
    }

    func execute<T>(profileId: String, command: AddTrackCommand, transformer: (Track) -> T) throws -> T {
        let track = Track(
            id: trackRepository.nextId(),
            ownedBy: ProfileId(profileId),
            title: try TrackTitle("Still More Fighting"),
            comment: try TrackComment("Best boss battle"),
            score: try TrackScore(10),
            createdOn: Date()
        )

        let savedTrack = try trackRepository.save(track)

        return transformer(savedTrack)
    }
}

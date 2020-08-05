import Foundation
import Interface


struct AddTrackUseCase {
    private let trackRepository: TrackRepository
    private let profileAuthorizationService: ProfileAuthorizationService

    init(
        trackRepository: TrackRepository,
        profileAuthorizationService: ProfileAuthorizationService = ProfileAuthorizationService()
    ) {
        self.trackRepository = trackRepository
        self.profileAuthorizationService = profileAuthorizationService
    }

    func execute<T>(
        sessionProfileId: String,
        profileId: String,
        command: AddTrackCommand,
        transformer: (Track) -> T
    ) throws -> T {
        try profileAuthorizationService.validateAccess(
            for: ProfileId(sessionProfileId),
            on: ProfileId(profileId)
        )

        let track = Track(
            id: trackRepository.nextId(),
            ownedBy: ProfileId(profileId),
            title: try TrackTitle(command.title),
            comment: try TrackComment(command.comment),
            score: try TrackScore(command.score),
            createdOn: Date()
        )

        let savedTrack = try trackRepository.save(track)

        return transformer(savedTrack)
    }
}

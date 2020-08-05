import Foundation


struct GetOneTrackUseCase {
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
        trackId: String, transformer: (Track) -> T
    ) throws -> T {
        try profileAuthorizationService.validateAccess(for: sessionProfileId, on: profileId)

        let profileId = ProfileId(profileId)
        let trackId = TrackId(trackId)

        guard let track = try trackRepository.findById(trackId) else {
            throw NotFoundError(message: "the track with id \(trackId.value) was not found")
        }

        if track.ownedBy != profileId {
            throw UnauthorizedError(
                message: "Profile id \(profileId.value) is not authorized to access the track with id \(trackId.value)"
            )
        }

        return transformer(track)
    }
}

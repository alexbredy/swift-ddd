import Foundation


struct GetOneTrackUseCase {

    private let trackRepository: TrackRepository

    init(trackRepository: TrackRepository) {
        self.trackRepository = trackRepository
    }

    func execute<T>(profileId: String, trackId: String, transformer: (Track) -> T) throws -> T {
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

import Foundation


struct GetOneTrackUseCase {

    private let trackRepository: TrackRepository

    func execute<T>(profileId: String, trackId: String, transformer: (Track) -> T) throws -> T {
        let profileId = ProfileId(profileId)
        let trackId = TrackId(trackId)

        guard let track = try trackRepository.findById(trackId) else {
            throw NotFoundError(message: "the track with id \(trackId.value.uuidString) was not found")
        }

        if track.ownedBy != profileId {
            throw UnauthorizedError(
                message: "Profile id \(profileId.description) is not authorized to access the track with id \(trackId.description)"
            )
        }

        return transformer(track)
    }
}

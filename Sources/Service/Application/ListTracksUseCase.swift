import Foundation


struct ListTracksUseCase {

    private let trackRepository: TrackRepository

    func execute<T>(profileId: String, transformer: ([Track]) -> [T]) throws -> [T] {
        let profileId = ProfileId(profileId)

        let tracks = try trackRepository.list(for: profileId)

        return transformer(tracks)
    }
}
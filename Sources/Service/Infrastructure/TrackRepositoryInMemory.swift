import Foundation


class TrackRepositoryInMemory: TrackRepository {
    private var tracks: [Track] = []

    func nextId() -> TrackId {
        TrackId(UUID().uuidString)
    }

    func findById(_ id: TrackId) throws -> Track? {
        tracks.filter { $0.id == id }.first
    }

    func list(for profileId: ProfileId) throws -> [Track] {
        tracks
            .filter { $0.ownedBy == profileId }
            .sorted { $0.createdOn > $1.createdOn }
    }

    func save(_ track: Track) throws -> Track {
        if let existingTrackIndex = tracks.firstIndex(where: { $0.id == track.id }) {
            tracks[existingTrackIndex] = track
        } else {
            tracks.append(track)
        }

        return track
    }
}

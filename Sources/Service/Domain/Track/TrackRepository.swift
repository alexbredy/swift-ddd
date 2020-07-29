import Foundation


protocol TrackRepository {
    func nextId() -> TrackId
    func findById(_ id: TrackId) throws -> Track?
    func list(for profileId: ProfileId) throws -> [Track]
    func save(_ track: Track) throws -> Track
}

import Foundation


protocol TrackRepository {
    func findById(_ id: TrackId) throws -> Track?
    func list(for profileId: ProfileId) throws -> [Track]
    func save(_ track: Track) throws -> Track
}

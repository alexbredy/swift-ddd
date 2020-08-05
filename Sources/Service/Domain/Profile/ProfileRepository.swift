import Foundation


protocol ProfileRepository {
    func nextId() -> ProfileId
    func findById(_ id: ProfileId) throws -> Profile?
    func save(_ profile: Profile) throws -> Profile
}

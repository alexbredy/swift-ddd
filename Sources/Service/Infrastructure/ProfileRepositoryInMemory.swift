import Foundation


class ProfileRepositoryInMemory: ProfileRepository {
    private var profiles: [ProfileId: Profile] = [:]

    func nextId() -> ProfileId {
        ProfileId(UUID().uuidString)
    }

    func findById(_ id: ProfileId) throws -> Profile? {
        profiles[id]
    }

    func save(_ profile: Profile) throws -> Profile {
        profiles[profile.id] = profile

        return profile
    }


}

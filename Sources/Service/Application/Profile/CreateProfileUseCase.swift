import Foundation
import Interface


struct CreateProfileUseCase {
    private let profileRepository: ProfileRepository

    init(profileRepository: ProfileRepository) {
        self.profileRepository = profileRepository
    }

    func execute<T>(createProfileCommand: CreateProfileCommand, transformer: (Profile) -> T) throws -> T {
        let username = try ProfileUsername(createProfileCommand.username)

        let profile = Profile(
            id: profileRepository.nextId(),
            username: username,
            createdOn: Date()
        )

        let savedProfile = try profileRepository.save(profile)

        return transformer(savedProfile)
    }
}

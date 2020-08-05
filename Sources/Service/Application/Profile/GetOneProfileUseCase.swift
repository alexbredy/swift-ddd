import Foundation
import Interface


struct GetOneProfileUseCase {
    private let profileRepository: ProfileRepository
    private let profileAuthorizationService: ProfileAuthorizationService

    init(
        profileRepository: ProfileRepository,
        profileAuthorizationService: ProfileAuthorizationService = ProfileAuthorizationService()
    ) {
        self.profileRepository = profileRepository
        self.profileAuthorizationService = profileAuthorizationService
    }

    func execute<T>(sessionProfileId: String, profileId: String, transformer: (Profile) -> T) throws -> T {
        try profileAuthorizationService.validateAccess(
            for: ProfileId(sessionProfileId),
            on: ProfileId(profileId)
        )

        guard let profile = try profileRepository.findById(ProfileId(profileId)) else {
            throw NotFoundError(message: "The profile does not exist")
        }

        return transformer(profile)
    }
}

import Foundation


struct CreateSessionUseCase {
    private static let sessionLifetimeInDays = 1

    private let sessionRepository: SessionRepository
    private let profileRepository: ProfileRepository

    init(
        sessionRepository: SessionRepository,
        profileRepository: ProfileRepository
    ) {
        self.sessionRepository = sessionRepository
        self.profileRepository = profileRepository
    }

    //No auth required to create a Session for the sake of simplicity in this project
    func execute<T>(profileId: String, transformer: (Session) -> T) throws -> T {
        let profileId = ProfileId(profileId)

        guard let profile = try profileRepository.findById(profileId) else {
            throw NotFoundError(message: "The profile \(profileId.value) does not exist")
        }

        let session = Session(
            token: sessionRepository.nextToken(),
            profileId: profile.id
        )

        let savedSession = try sessionRepository.save(session)

        return transformer(savedSession)
    }
}

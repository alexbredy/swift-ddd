import Foundation


struct CreateSessionUseCase {
    private static let sessionLifetimeInDays = 1

    private let sessionRepository: SessionRepository
    private let profileRepository: ProfileRepository
    private let calendar: Calendar

    init(
        sessionRepository: SessionRepository,
        profileRepository: ProfileRepository,
        calendar: Calendar = Calendar.current
    ) {
        self.sessionRepository = sessionRepository
        self.profileRepository = profileRepository
        self.calendar = calendar
    }

    //No auth required to create a Session for the sake of simplicity in this project
    func execute<T>(profileId: String, transformer: (Session) -> T) throws -> T {
        let profileId = ProfileId(profileId)

        guard let profile = try profileRepository.findById(profileId) else {
            throw NotFoundError(message: "The profile \(profileId.value) does not exist")
        }

        let session = Session(
            token: sessionRepository.nextToken(),
            profileId: profile.id,
            expiresOn: makeSessionExpiryDate()
        )

        let savedSession = try sessionRepository.save(session)

        return transformer(savedSession)
    }

    private func makeSessionExpiryDate() -> Date {
        var days    = DateComponents()
        days.day    = CreateSessionUseCase.sessionLifetimeInDays

        return calendar.date(byAdding: days, to: Date())!
    }
}

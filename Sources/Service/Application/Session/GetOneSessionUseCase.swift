import Foundation


struct GetOneSessionUseCase {
    private let sessionRepository: SessionRepository

    func execute<T>(token: String, transformer: (Session) -> T) throws -> T {
        guard let session = try sessionRepository.findByToken(SessionToken(token)) else {
            throw NotFoundError(message: "The session does not exist")
        }

        return transformer(session)
    }
}

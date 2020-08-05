import Foundation


class SessionRepositoryInMemory: SessionRepository {
    private var sessions: [SessionToken: Session] = [:]

    func nextToken() -> SessionToken {
        SessionToken(UUID().uuidString)
    }

    func findByToken(_ token: SessionToken) throws -> Session? {
        sessions[token]
    }

    func save(_ session: Session) throws -> Session {
        sessions[session.token] = session

        return session
    }
}

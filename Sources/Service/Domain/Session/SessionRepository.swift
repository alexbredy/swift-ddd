import Foundation


protocol SessionRepository {
    func nextToken() -> SessionToken
    func findByToken(_ token: SessionToken) throws -> Session?
    func save(_ session: Session) throws -> Session
}

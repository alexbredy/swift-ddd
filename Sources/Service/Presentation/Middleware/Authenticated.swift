import Foundation
import Vapor
import Interface
import Resolver


extension SessionDto: Authenticatable {
}


struct Authenticated: BearerAuthenticator {

    private let getOneSessionUseCase: GetOneSessionUseCase

    init(getOneSessionUseCase: GetOneSessionUseCase = Resolver.resolve()) {
        self.getOneSessionUseCase = getOneSessionUseCase
    }

    func authenticate(request: Request) -> EventLoopFuture<Void> {
        guard let bearerAuthorization = request.headers.bearerAuthorization else {
            return request.eventLoop.makeFailedFuture(Abort(.unauthorized))
        }
        return self.authenticate(bearer: bearerAuthorization, for: request)
    }

    func authenticate(bearer: BearerAuthorization, for request: Request) -> EventLoopFuture<Void> {
        guard let session = try? getOneSessionUseCase.execute(
            token: bearer.token,
            transformer: SessionTransformer.toDto(_:)
        ) else {
            return request.eventLoop.makeFailedFuture(Abort(.unauthorized))
        }

        guard session.expiresOn <= Date() else {
            return request.eventLoop.makeFailedFuture(Abort(.unauthorized))
        }

        request.auth.login(session)
        return request.eventLoop.makeSucceededFuture(())
    }
}

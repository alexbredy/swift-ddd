import Foundation
import Vapor
import Resolver
import Interface


extension CreateProfileCommand: Content {}
extension ProfileDto: Content {}


struct ProfilesController: RouteCollection {
    private let getOneProfileUseCase: GetOneProfileUseCase
    private let createProfileUseCase: CreateProfileUseCase

    init(
        getOneProfileUseCase: GetOneProfileUseCase = Resolver.resolve(),
        createProfileUseCase: CreateProfileUseCase = Resolver.resolve()
    ){
        self.getOneProfileUseCase = getOneProfileUseCase
        self.createProfileUseCase = createProfileUseCase
    }

    func boot(routes: RoutesBuilder) throws {
        let v1 = routes.grouped("v1", "profiles")
        let v1Authenticated = v1.grouped(Authenticated())

        v1Authenticated.get(":profileId", use: getOne(_:))
        v1.post(use: create(_:))
    }

    func getOne(_ request: Request) throws -> ProfileDto {
        let sessionProfileId = try request.auth.require(SessionDto.self).profileId
        let profileId = request.parameters.get("profileId")!

        return try getOneProfileUseCase.execute(
            sessionProfileId: sessionProfileId,
            profileId: profileId,
            transformer: ProfileTransformer.toDto(_:)
        )
    }

    func create(_ request: Request) throws -> ProfileDto {
        let command = try request.content.decode(CreateProfileCommand.self)

        return try createProfileUseCase.execute(
            createProfileCommand: command,
            transformer: ProfileTransformer.toDto(_:)
        )
    }
}

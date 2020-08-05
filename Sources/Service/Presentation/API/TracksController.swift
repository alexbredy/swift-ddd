import Foundation
import Vapor
import Resolver
import Interface


extension AddTrackCommand: Content {}
extension TrackDto: Content {}


struct TracksController: RouteCollection {
    private let addTrackUseCase: AddTrackUseCase
    private let getOneTrackUseCase: GetOneTrackUseCase
    private let listTracksUseCase: ListTracksUseCase

    init(
        addTrackUseCase: AddTrackUseCase = Resolver.resolve(),
        getOneTrackUseCase: GetOneTrackUseCase = Resolver.resolve(),
        listTracksUseCase: ListTracksUseCase = Resolver.resolve()
    ) {
        self.addTrackUseCase = addTrackUseCase
        self.getOneTrackUseCase = getOneTrackUseCase
        self.listTracksUseCase = listTracksUseCase
    }

    func boot(routes: RoutesBuilder) throws {
        let v1 = routes
            .grouped("v1", "profiles", ":profileId", "tracks")
            .grouped(Authenticated())

        v1.get(use: listTracks)
        v1.get(":trackId", use: listTracks)
        v1.post(use: addTrack)
    }

    func getOne(_ request: Request) throws -> TrackDto {
        let sessionProfileId = try request.auth.require(SessionDto.self).profileId
        let profileId = request.parameters.get("profileId")!
        let trackId = request.parameters.get("trackId")!

        return try getOneTrackUseCase.execute(
            sessionProfileId: sessionProfileId,
            profileId: profileId,
            trackId: trackId,
            transformer: TrackTransformer.toDto(_:)
        )
    }

    func listTracks(_ request: Request) throws -> [TrackDto] {
        let sessionProfileId = try request.auth.require(SessionDto.self).profileId
        let profileId = request.parameters.get("profileId")!

        return try listTracksUseCase.execute(
            sessionProfileId: sessionProfileId,
            profileId: profileId,
            transformer: TrackTransformer.toDto(_:)
        )
    }

    func addTrack(_ request: Request) throws -> TrackDto {
        let sessionProfileId = try request.auth.require(SessionDto.self).profileId
        let profileId = request.parameters.get("profileId")!
        let command = try request.content.decode(AddTrackCommand.self)

        return try addTrackUseCase.execute(
            sessionProfileId: sessionProfileId,
            profileId: profileId,
            command: command,
            transformer: TrackTransformer.toDto(_:)
        )
    }
}

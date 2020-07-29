import Foundation
import Vapor
import Resolver
import Interface


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
        let v1 = routes.grouped("v1", "profiles", ":profileId")

        v1.get("tracks", use: listTracks)
        v1.get("tracks", ":trackId", use: listTracks)
        v1.post("tracks", use: addTrack)
    }

    func getOne(_ request: Request) throws -> TrackDto {
        let profileId = request.parameters.get("profileId")!
        let trackId = request.parameters.get("trackId")!

        return try getOneTrackUseCase.execute(profileId: profileId, trackId: trackId) { $0.toDto() }
    }

    func listTracks(_ request: Request) throws -> [TrackDto] {
        let profileId = request.parameters.get("profileId")!

        return try listTracksUseCase.execute(profileId: profileId) { $0.toDto() }
    }

    func addTrack(_ request: Request) throws -> TrackDto {
        let profileId = request.parameters.get("profileId")!
        let command = try request.content.decode(AddTrackCommand.self)

        return try addTrackUseCase.execute(profileId: profileId, command: command) { $0.toDto() }
    }
}

extension Track {
    func toDto() -> TrackDto {
        return TrackDto(
            id: id.value,
            ownedBy: ownedBy.value,
            title: title.value,
            comment: comment.value,
            score: score.value,
            createdOn: createdOn
        )
    }
}

extension TrackDto: Content {
}

extension AddTrackCommand: Content {
}

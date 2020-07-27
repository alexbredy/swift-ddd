import Foundation
import Vapor
import Resolver


struct TracksController: Controller {

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

    func configureRoutes(_ routesBuilder: RoutesBuilder) {

    }
}

import Vapor
import Resolver


public extension Application {
    func configure() throws {
        let lifecycleHandler = ApplicationLifecycleHandler()

        lifecycle.use(lifecycleHandler)

        RepositoryConfiguration.registerRepositories(app: self, lifecycleHandler: lifecycleHandler)
        UseCaseConfiguration.registerUseCases()

        try registerRoutes()
    }

    private func registerRoutes() throws {
        let tracksController = TracksController(
            addTrackUseCase: Resolver.resolve(),
            getOneTrackUseCase: Resolver.resolve(),
            listTracksUseCase: Resolver.resolve()
        )

        try routes.register(collection: tracksController)
    }
}

import Foundation
import Resolver
import Vapor
import PostgresKit


struct RepositoryConfiguration {
    static func registerRepositories(app: Application, lifecycleHandler: ApplicationLifecycleHandler) {
        registerTrackRepository(app: app, lifecycleHandler: lifecycleHandler)
    }

    private static func registerTrackRepository(
        app: Application,
        lifecycleHandler: ApplicationLifecycleHandler
    ) {
        switch app.environment {
        case .development, .testing:
            Resolver.register {
                TrackRepositoryInMemory()
            }.implements(TrackRepository.self).scope(Resolver.application)
        case .production:
            let postgresClient = makePostgresClient(app: app, lifecycleHandler: lifecycleHandler)

            Resolver.register {
                TrackRepositoryPostgreSql(client: postgresClient)
            }.implements(TrackRepository.self).scope(Resolver.application)
        default:
            fatalError("The environment is invalid")
        }
    }

    private static func registerSessionRepository(
        app: Application,
        lifecycleHandler: ApplicationLifecycleHandler
    ) {
        switch app.environment {
        case .development, .testing:
            Resolver.register {
                SessionRepositoryInMemory()
            }.implements(TrackRepository.self).scope(Resolver.application)
        case .production:
            fatalError("Implement this")
        default:
            fatalError("The environment is invalid")
        }
    }

    private static func registerProfileRepository(
        app: Application,
        lifecycleHandler: ApplicationLifecycleHandler
    ) {
        switch app.environment {
        case .development, .testing:
            Resolver.register {
                ProfileRepositoryInMemory()
            }.implements(TrackRepository.self).scope(Resolver.application)
        case .production:
            fatalError("Implement this")
        default:
            fatalError("The environment is invalid")
        }
    }

    private static func makePostgresClient(
        app: Application,
        lifecycleHandler: ApplicationLifecycleHandler
    ) -> PostgresDatabase {
        let url = URL(string: "postgres://erwerwrewr")!

        let pools = EventLoopGroupConnectionPool(
            source: PostgresConnectionSource(configuration: PostgresConfiguration(url: url)!),
            on: app.eventLoopGroup
        )

        lifecycleHandler.addShutdownHandler {
            try! pools.syncShutdownGracefully()
        }

        return pools.database(logger: app.logger)
    }
}

import Foundation
import Resolver


struct UseCaseConfiguration {
    static func registerUseCases() {
        Resolver.register {
            AddTrackUseCase(trackRepository: Resolver.resolve())
        }.scope(Resolver.application)

        Resolver.register {
            GetOneTrackUseCase(trackRepository: Resolver.resolve())
        }.scope(Resolver.application)

        Resolver.register {
            ListTracksUseCase(trackRepository: Resolver.resolve())
        }.scope(Resolver.application)
    }
}

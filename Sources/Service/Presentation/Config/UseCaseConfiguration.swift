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

        Resolver.register {
            CreateProfileUseCase(profileRepository: Resolver.resolve())
        }.scope(Resolver.application)

        Resolver.register {
            GetOneProfileUseCase(profileRepository: Resolver.resolve())
        }.scope(Resolver.application)

        Resolver.register {
            CreateSessionUseCase(
                sessionRepository: Resolver.resolve(),
                profileRepository: Resolver.resolve()
            )
        }.scope(Resolver.application)

        Resolver.register {
            GetOneSessionUseCase(sessionRepository: Resolver.resolve())
        }.scope(Resolver.application)
    }
}

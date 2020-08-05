import Foundation


struct ListTracksUseCase {
    private let trackRepository: TrackRepository
    private let profileAuthorizationService: ProfileAuthorizationService

    init(
        trackRepository: TrackRepository,
        profileAuthorizationService: ProfileAuthorizationService = ProfileAuthorizationService()
    ) {
        self.trackRepository = trackRepository
        self.profileAuthorizationService = profileAuthorizationService
    }
    
    func execute<T>(sessionProfileId: String, profileId: String, transformer: (Track) -> T) throws -> [T] {
        try profileAuthorizationService.validateAccess(
            for: ProfileId(sessionProfileId),
            on: ProfileId(profileId)
        )

        let profileId = ProfileId(profileId)
        
        let tracks = try trackRepository.list(for: profileId)
        
        return tracks.map { transformer($0) }
    }
}

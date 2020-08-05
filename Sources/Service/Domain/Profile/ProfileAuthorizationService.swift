import Foundation


struct ProfileAuthorizationService {
    func validateAccess(for sessionProfileId: ProfileId, on requestedProfileId: ProfileId) throws {
        if sessionProfileId != requestedProfileId {
            throw UnauthorizedError(message: "Unauthorized access to profile \(requestedProfileId)")
        }
    }
}

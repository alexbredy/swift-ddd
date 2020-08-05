import Foundation


struct ProfileAuthorizationService {
    func validateAccess(for sessionProfileId: String, on requestedProfileId: String) throws {
        if sessionProfileId != requestedProfileId {
            throw UnauthorizedError(message: "Unauthorized access to profile \(requestedProfileId)")
        }
    }
}

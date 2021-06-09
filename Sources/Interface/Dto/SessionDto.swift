import Foundation


public struct SessionDto: Codable {
    public let token: String
    public let profileId: String

    public init(token: String, profileId: String) {
        self.token = token
        self.profileId = profileId
    }
}


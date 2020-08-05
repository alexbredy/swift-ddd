import Foundation


public struct SessionDto: Codable {
    public let token: String
    public let profileId: String
    public let expiresOn: Date

    public init(token: String, profileId: String, expiresOn: Date) { 
        self.token = token
        self.profileId = profileId
        self.expiresOn = expiresOn
    }
}


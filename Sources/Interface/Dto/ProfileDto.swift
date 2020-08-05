import Foundation


public struct ProfileDto: Codable {
    public let id: String
    public let username: String
    public let createdOn: Date

    public init(id: String, username: String, createdOn: Date) {
        self.id = id
        self.username = username
        self.createdOn = createdOn
    }
}

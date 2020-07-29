import Foundation


public struct TrackDto: Codable {
    public let id: String
    public let ownedBy: String
    public let title: String
    public let comment: String
    public let score: Int
    public let createdOn: Date

    public init(
        id: String,
        ownedBy: String,
        title: String,
        comment: String,
        score: Int,
        createdOn: Date
    ) {
        self.id = id
        self.ownedBy = ownedBy
        self.title = title
        self.comment = comment
        self.score = score
        self.createdOn = createdOn
    }
}

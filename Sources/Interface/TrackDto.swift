import Foundation


struct TrackDto: Codable {
    let id: String
    let ownedBy: String
    let name: String
    let comment: String
    let score: Int
    let createdOn: Date
}

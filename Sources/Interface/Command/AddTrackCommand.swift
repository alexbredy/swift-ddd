import Foundation


public struct AddTrackCommand: Codable {
    public let title: String
    public let comment: String
    public let score: Int
}

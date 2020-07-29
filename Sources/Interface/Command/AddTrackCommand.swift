import Foundation


public struct AddTrackCommand: Codable {
    let title: String
    let comment: String
    let score: Int
}

import Foundation


struct Track {
    let id: TrackId
    let ownedBy: ProfileId
    let title: TrackTitle
    let comment: TrackComment
    let score: TrackScore
    let createdOn: Date
}

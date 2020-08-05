import Foundation
import Interface


struct TrackTransformer {
    static func toDto(_ track: Track) -> TrackDto {
        return TrackDto(
            id: track.id.value,
            ownedBy: track.ownedBy.value,
            title: track.title.value,
            comment: track.comment.value,
            score: track.score.value,
            createdOn: track.createdOn
        )
    }
}

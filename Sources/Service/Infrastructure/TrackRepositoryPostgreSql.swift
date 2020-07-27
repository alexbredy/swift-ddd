import Foundation
import PostgresKit


class TrackRepositoryPostgreSql: TrackRepository {

    private let database: PostgresDatabase

    init(database: PostgresDatabase) {
        self.database = database
    }

    func findById(_ id: TrackId) throws -> Track? {
        let result = try database.query(
            "SELECT * FROM tracks WHERE id = $1",
            [PostgresData(string: id.value.uuidString)]
        ).wait()

        guard let row = result.first else {
            return nil
        }

        return makeTrack(from: row)
    }

    func list(for profileId: ProfileId) throws -> [Track] {
        let result = try database.query(
            "SELECT * FROM tracks WHERE owned_by = $1",
            [PostgresData(string: profileId.value.uuidString)]
        ).wait()

        return result.map { makeTrack(from: $0) }
    }

    func save(_ track: Track) throws -> Track {
//        let result = try database.query(
//            "INSERT INTO",
//            [PostgresData]
//        )

        return track
    }

    private func makeTrack(from row: PostgresRow) -> Track {
        return Track(
            id: TrackId(row.column("id")!.string!),
            ownedBy: ProfileId(row.column("profileId")!.string!),
            title: try! TrackTitle(row.column("name")!.string!),
            comment: try! TrackComment(row.column("comment")!.string!),
            score: try! TrackScore(row.column("score")!.int!),
            createdOn: row.column("createdOn")!.date!
        )
    }
}

import Foundation
import Interface


struct ProfileTransformer {
    static func toDto(_ profile: Profile) -> ProfileDto {
        return ProfileDto(
            id: profile.id.value,
            username: profile.username.value,
            createdOn: profile.createdOn
        )
    }
}

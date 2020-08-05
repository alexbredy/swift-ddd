import Foundation
import Interface


struct SessionTransformer {
    static func toDto(_ session: Session) -> SessionDto {
        return SessionDto(
            token: session.token.value,
            profileId: session.profileId.value,
            expiresOn: session.expiresOn
        )
    }
}

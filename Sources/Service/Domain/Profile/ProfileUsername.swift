import Foundation


struct ProfileUsername {
    private static let minLength = 2
    private static let maxLength = 16

    let value: String

    init(_ value: String) throws {
        guard ProfileUsername.minLength...ProfileUsername.maxLength ~= value.count else {
            throw DomainError(
                code: .invalidProfileName,
                message: "The profile name should be between \(ProfileUsername.minLength) and \(ProfileUsername.maxLength) characters"
            )
        }

        self.value = value
    }
}

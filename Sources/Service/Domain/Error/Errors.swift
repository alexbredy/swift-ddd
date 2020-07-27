import Foundation


enum ErrorCode: String {
    case notFound = "NOT_FOUND"
    case unauthorized = "UNAUTHORIZED"
    case invalidProfileName = "INVALID_PROFILE_NAME"
    case invalidTrackName = "INVALID_TRACK_NAME"
    case invalidTrackScore = "INVALID_TRACK_SCORE"
    case invalidTrackComment = "INVALID_TRACK_COMMENT"
}


protocol ServiceError: Error {
    var code: ErrorCode { get }
    var message: String { get }
}


struct DomainError: ServiceError {
    let code: ErrorCode
    let message: String
}


struct DomainCriticalError: ServiceError {
    let code: ErrorCode
    let message: String
}


struct NotFoundError: ServiceError {
    let code = ErrorCode.notFound
    let message: String
}


struct UnauthorizedError: ServiceError {
    let code = ErrorCode.unauthorized
    let message: String
}

import Foundation
import Vapor
import Resolver
import Interface


struct SessionController: RouteCollection {
    private let createSessionUseCase: CreateSessionUseCase

    init(createSessionUseCase: CreateSessionUseCase = Resolver.resolve()){
        self.createSessionUseCase = createSessionUseCase
    }

    func boot(routes: RoutesBuilder) throws {
        let v1 = routes.grouped("v1", "sessions")

        v1.post(use: create(_:))
    }

    func getOne(_ request: Request) throws -> String {
        return ""
    }

    func create(_ request: Request) throws -> String {
        return ""
    }
}

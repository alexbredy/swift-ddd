import Foundation
import Vapor


class ServiceLifecycleHandler: LifecycleHandler {

    typealias ShutdownHandler = () -> Void

    private var shutdownHandlers: [ShutdownHandler] = []

    func addShutdownHandler(_ handler: @escaping ShutdownHandler) {
        shutdownHandlers.append(handler)
    }

    func shutdown(_ application: Application) {
        shutdownHandlers.forEach { $0() }
    }
}

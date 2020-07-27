import Foundation
import Vapor


protocol Controller {
    func configureRoutes(_ routesBuilder: RoutesBuilder)
}

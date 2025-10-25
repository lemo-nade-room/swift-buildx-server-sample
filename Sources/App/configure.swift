import Vapor

func configure(_ app: Application) async throws {
  app.middleware.use(TestMiddleware())
  app.get("**") { req in
    req.url.path
  }

  app.get("hello") { _ in
    "Hello, World!"
  }
}
struct TestMiddleware: AsyncMiddleware {
  func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
    print("💙")
    print(request.method)
    print(request.parameters)
    print(request.url)
    return try await next.respond(to: request)
  }
}

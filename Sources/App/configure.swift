import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    
    // middleware
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // database
    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "danielweatrowski",
        password: Environment.get("DATABASE_PASSWORD") ?? "danielweatrowski",
        database: Environment.get("DATABASE_NAME") ?? "danielweatrowski"
    ), as: .psql)

    // migrations
    app.migrations.add(CreateThing())
    app.migrations.add(CreateThingData())

    // view
    app.views.use(.leaf)

    // routes
    try routes(app)
}

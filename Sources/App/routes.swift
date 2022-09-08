import Fluent
import Vapor

func routes(_ app: Application) throws {

    // Website Registration
    try app.register(collection: IndexController())
    
    // API Registration
    let api = app.grouped("api", "v1")
    try api.register(collection: ThingController())
    try api.register(collection: ThingDataController())
}

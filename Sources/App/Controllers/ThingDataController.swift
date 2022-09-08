//
//  ThingDataController.swift
//
//
//  Created by Daniel Weatrowski on 8/28/22.
//

import Fluent
import Vapor

struct ThingDataController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let thingData = routes.grouped("data")
        thingData.get(use: index)
        thingData.post(use: create)
    }

    func index(req: Request) async throws -> [ThingData] {
        try await ThingData.query(on: req.db).all()
    }

    func create(req: Request) async throws -> ThingData {
        
        let data = try req.content.decode(ThingData.self)
        try await data.save(on: req.db)
        return data
    }
}

//
//  ThingController.swift
//  
//
//  Created by Daniel Weatrowski on 8/28/22.
//

import Fluent
import Vapor

struct ThingController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let things = routes.grouped("things")
        things.get(use: index)
        things.get(":thingID", use: read)
        things.post(use: create)
    }

    func index(req: Request) async throws -> [Thing] {
        try await Thing.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Thing {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let thing = try req.content.decode(Thing.self, using: decoder)
        
        try await thing.save(on: req.db)
        return thing
    }
    
    func read(req: Request) async throws -> Thing {
        guard let thing = try await Thing.find(req.parameters.get("thingID"), on: req.db) else {
            throw Abort(.notFound)
        }
        return thing
    }
}

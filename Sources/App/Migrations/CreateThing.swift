//
//  CreateThing.swift
//  
//
//  Created by Daniel Weatrowski on 8/28/22.
//

import Fluent

struct CreateThing: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(Thing.schema)
            .id()
            .field("type", .string, .required)
            .field("created_at", .datetime, .required)
            .field("modified_at", .datetime, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(Thing.schema).delete()
    }
}

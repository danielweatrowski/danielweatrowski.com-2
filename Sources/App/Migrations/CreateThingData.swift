//
//  CreateThingData.swift
//  
//
//  Created by Daniel Weatrowski on 8/28/22.
//

import Fluent

struct CreateThingData: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(ThingData.schema)
            .id()
            .field("thing_id", .uuid, .required, .references(Thing.schema, "id"))
            .field("key", .string, .required)
            .field("value", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema(ThingData.schema).delete()
    }
}

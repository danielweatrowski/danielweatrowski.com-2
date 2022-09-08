//
//  Thing.swift
//  
//
//  Created by Daniel Weatrowski on 8/28/22.
//

import Fluent
import Vapor

final class Thing: Model, Content {
    static let schema = "thing"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "type")
    var type: String
    
    @Field(key: "created_at")
    var createdAt: Date
    
    @Field(key: "modified_at")
    var modifiedAt: Date
    
    @Children(for: \.$thing)
    var datas: [ThingData]

    init() { }

    init(id: UUID? = nil, type: String, createdAt: Date = Date(), modifiedAt: Date = Date()) {
        self.id = id
        self.type = type
        self.createdAt = createdAt
        self.modifiedAt = modifiedAt
    }
}

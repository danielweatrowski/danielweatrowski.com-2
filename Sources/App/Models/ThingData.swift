//
//  Data.swift
//  
//
//  Created by Daniel Weatrowski on 8/28/22.
//

import Fluent
import Vapor

final class ThingData: Model, Content {
    static let schema = "thing_data"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "thing_id")
    var thing: Thing

    @Field(key: "key")
    var key: String
    
    @Field(key: "value")
    var value: String

    init() { }

    init(id: UUID? = nil, thingID: UUID , key: String, value: String) {
        self.id = id
        self.$thing.id = thingID
        self.key = key
        self.value = value
    }
}

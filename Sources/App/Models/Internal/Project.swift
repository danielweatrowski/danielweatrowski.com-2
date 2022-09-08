//
//  Project.swift
//  
//
//  Created by Daniel Weatrowski on 8/29/22.
//

import Vapor
import Foundation

final class Project: Content, Encodable {
    static var ThingType = "project"
    
    enum DataKeys: String {
        case name, description, release_date
    }
    
    var name: String
    var description: String
    var releaseDate: String
    
    init(datas: [ThingData]) {
        self.name = datas.first(where: {$0.key == DataKeys.name.rawValue})?.value ?? "NULL"
        self.description = datas.first(where: {$0.key == DataKeys.description.rawValue})?.value ?? "NULL"
        let releaseDate = datas.first(where: {$0.key == DataKeys.release_date.rawValue})?.value ?? "2022-12-01T00:00:00Z"
        
        let isoFormatter = ISO8601DateFormatter()
        let date = isoFormatter.date(from: releaseDate) ?? Date()
        
        let df = DateFormatter()
        df.dateFormat = "MMMM yyyy"
        df.timeZone = TimeZone(identifier: "UTC")
        let releaseDateString = df.string(from: date)
        
        self.releaseDate = releaseDateString
    }
}

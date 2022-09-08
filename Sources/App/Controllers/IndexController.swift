//
//  MainController.swift
//  
//
//  Created by Daniel Weatrowski on 8/29/22.
//

import Vapor
import Fluent
import Leaf

struct IndexController: RouteCollection {
    
    struct IndexContext: Codable {
        let name: String
        let projects: [Project]
    }
    
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: index)
    }
    
    func index(req: Request) async throws -> View {
        // idea: Create a generic thing (factory?) class to handle this for the different internal models
        let projectThings = try await Thing.query(on: req.db)
            .filter(\.$type == Project.ThingType)
            .with(\.$datas)
            .all()
        
        var projects = [Project]()
        for thing in projectThings {
            let project = Project(datas: thing.datas)
            projects.append(project)
        }
        
        return try await req.view.render("index", IndexContext(name: "Daniel Weatrowski", projects: projects))
    }
}

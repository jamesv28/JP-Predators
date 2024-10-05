//
//  ApexPredator.swift
//  JP-Predators
//
//  Created by James Volmert on 10/4/24.
//

import Foundation

// if you don't need classes, choose struct
struct ApexPredator: Decodable {
    let id: Int
    let name: String
    let type: String
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    struct MovieScene: Decodable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}

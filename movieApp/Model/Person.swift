//
//  Person.swift
//  movieApp
//
//  Created by Temitope on 01/09/2021.
//



import Foundation

// MARK: - Person
struct Person: Codable {
    let results: [Results]?
}

// MARK: - Result
struct Results: Codable {
    let adult: Bool?
    let gender, id: Int?
    let name: String?
    let popularity: Double?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case name, popularity
        case profilePath = "profile_path"
    }
}


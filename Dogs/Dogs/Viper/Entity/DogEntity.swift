//
//  DogEntity.swift
//  ApiDogsViper
//
//  Created by 1017143 on 15/11/22.
//

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let weight, height: Eight
    let id: Int
    let name: String
    let bredFor, breedGroup: String?
    let lifeSpan, temperament: String
    let origin: String?
    let referenceImageID: String
    let image: Image
    let countryCode, welcomeDescription, history: String?

    enum CodingKeys: String, CodingKey {
        case weight, height, id, name
        case bredFor = "bred_for"
        case breedGroup = "breed_group"
        case lifeSpan = "life_span"
        case temperament, origin
        case referenceImageID = "reference_image_id"
        case image
        case countryCode = "country_code"
        case welcomeDescription = "description"
        case history
    }
}

// MARK: - Eight
struct Eight: Codable {
    let imperial, metric: String
}

// MARK: - Image
struct Image: Codable {
    let id: String
    let width, height: Int
    let url: String
}

typealias Dogs = [WelcomeElement]
typealias Dog = WelcomeElement

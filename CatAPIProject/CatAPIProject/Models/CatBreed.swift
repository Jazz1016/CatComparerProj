//
//  CatBreed.swift
//  CatAPIProject
//
//  Created by James Lea on 5/5/21.
//

import Foundation

//struct TopLevelObject: Codable {
//    var arrayOfCatBreeds: [CatBreed] = Array()
//}

struct CatBreed: Codable {
    var name: String
    let description: String
    let weight: Weight
    //    let image: CatImage
    //    let origin: String
}

struct CatImage: Codable {
    let url: URL
}

struct Cat: Codable {
    var name: String
    let description: String
    let weight: Weight
    let reference_image_id: String
    let indoor: Int
    let adaptability: Int
    let affection_level: Int
    let child_friendly: Int
    let dog_friendly: Int
    let energy_level: Int
    let grooming: Int
    let health_issues: Int
    let intelligence: Int
    let shedding_level: Int
    let social_needs: Int
    let stranger_friendly: Int
    let vocalisation: Int
    let experimental: Int
    let hypoallergenic: Int
}

struct Weight: Codable {
    let imperial: String
}

//
//  Ingredient.swift
//  PinaMagic
//
//  Created by Arvind on 22/02/25.
//

import Foundation

// MARK: - Ingredient
enum IngredientType: String, Codable, CaseIterable {
    case all = "all"
    case alcoholic = "alcoholic"
    case nonAlcoholic = "non-alcoholic"
    
    var title: String {
        switch self {
        case .all: "All"
        case .alcoholic: "Alcoholic"
        case .nonAlcoholic: "Non-Alcoholic"
        }
    }
}

struct Ingredient: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let type: IngredientType
    let shortDescription: String
    let longDescription: String
    let preparationMinutes: Int?
    let imageName: String
    let image: String
    let ingredients: [String]
    var isLiked: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case type = "type"
        case shortDescription = "shortDescription"
        case longDescription = "longDescription"
        case preparationMinutes = "preparationMinutes"
        case imageName = "imageName"
        case image = "image"
        case ingredients = "ingredients"
    }
}

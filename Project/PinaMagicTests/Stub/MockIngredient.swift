//
//  MockIngredient.swift
//  PinaMagic
//
//  Created by Arvind on 26/02/25.
//

@testable import PinaMagic

struct MockIngredient {
    
    static let ingredient = Ingredient(id: "1",
                                       name: "Mojito",
                                       type: .alcoholic,
                                       shortDescription: "A refreshing Cuban classic made with white rum and muddled fresh mint.",
                                       longDescription: "This is an authentic recipe for mojito. I sized the recipe for one serving, but you can adjust it accordingly and make a pitcher full. It's a very refreshing drink for hot summer days. Be careful when drinking it, however. If you make a pitcher you might be tempted to drink the whole thing yourself, and you just might find yourself talking Spanish in no time! Tonic water can be substituted instead of the soda water but the taste is different and somewhat bitter.",
                                       preparationMinutes: 5,
                                       imageName: "Sample",
                                       image: "https://static.remove.bg/sample-gallery/graphics/bird-thumbnail.jpg",
                                       ingredients: ["1 measure pineapple juice",
                                                     "1 measure orange juice",
                                                     "1 measure freshly squeeze lime juice"],
                                       isLiked: true)
}

//
//  Food.swift
//  Tasty Food
//
//  Created by Leyla Jafarova on 18.12.22.
//

import Foundation

struct FoodsResponse: Codable {
    let foods: [Food]?
}

struct CartItemResponse: Codable {
    let foods_cart: [Food]?
}

struct Food: Codable {
    let id: Int?
    let cartId: Int?
    let name: String?
    let price: Int?
    let image: String?
    let category: String?
    var orderAmount: Int?
    let userName: String?
    
    var imageURL: URL? {
        guard let image = image else { return nil }
        return URL(string: NetworkService.baseImageURL + image)
    }
}


class CRUDResponse : Codable {
    var success: Int?
    var message: String?
}



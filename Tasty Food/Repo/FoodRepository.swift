//
//  FoodRepository.swift
//  Tasty Food
//
//  Created by Leyla Jafarova on 18.12.22.
//

import Foundation
import Alamofire

class FoodRepository {
    var networkService = NetworkService()
    
    func getList(completion: @escaping ([Food]) -> Void) {
        networkService.requestAllList() { response in
            if let foods = response.foods {
                completion(foods)
            } else {
                completion([])
            }
        }
    }
    
    func addItem(item: Food, orderCount: Int, completion: @escaping (CRUDResponse?) -> Void) {
        networkService.requestAddItem(params: getParams(item, orderCount)) { result in
           completion(result)
        }
    }
    
    func deleteItem(item: Food, orderCount: Int, completion: @escaping (CRUDResponse?) -> Void) {
        var param: Parameters = ["cartId": item.cartId ?? 0]
        param["userName"] = "leyla_jafarova"

        networkService.requestDeleteItem(params: param) { result in
            print(result?.message, result?.success)
           completion(result)
        }
    }
    
    func getAllCartItems(completion: @escaping (CartItemResponse?) -> Void) {
        networkService.requestAllCartItems { items in
            completion(items)
        }
    }
    
    func deleteCartItem(completion: @escaping (CartItemResponse?) -> Void) {
        networkService.requestAllCartItems { items in
            completion(items)
        }
    }
}

extension FoodRepository {
    private func getParams(_ item: Food, _ count: Int) -> Parameters {
        [
            "name": item.name ?? "",
            "price": item.price ?? 0,
            "image": item.image ?? "",
            "category": item.category ?? "",
            "orderAmount": count
        ]
    }
}

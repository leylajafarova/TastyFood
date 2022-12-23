//
//  CartViewModel.swift
//  Tasty Food
//
//  Created by Leyla Jafarova on 19.12.22.
//

import UIKit
import Kingfisher

class CartViewModel {
    let repo = FoodRepository()
    var foods: [Food] = []
    
    func calculateSumm() -> Int {
        var sum = 0
        for food in foods {
            sum += (food.price ?? 0)
        }
        return sum
    }
    func fetchCartItems(callback: EmptyCallback?) {
        repo.getAllCartItems { cartItems in
            self.foods = cartItems?.foods_cart ?? []
            callback?()
        }
    }
    
    func removeItem(food: Food, callback: EmptyCallback?) {
        repo.deleteItem(
            item: food,
            orderCount: food.orderAmount ?? 0) { [weak self] response in
                guard let self = self else { return }
                self.foods = self.foods.filter({ $0.cartId != food.cartId })
                callback?()
            }
    }
}

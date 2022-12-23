//
//  ListScreenViewModel.swift
//  Tasty Food
//
//  Created by Leyla Jafarova on 18.12.22.
//

import Foundation
import UIKit

typealias EmptyCallback = () -> Void

class ListScreenViewModel {
    
    private let repo = FoodRepository()
    public var foods: [Food] = []
    
    func fetchFoods(callback: EmptyCallback?) {
        repo.getList { foods in
            self.foods = foods
            callback?()
        }
    }
    
    func addItem(indexPath: IndexPath, count: Int) {
//        if let item = foods[indexPath.row] {
//            repo.addItem(item: item, orderCount: count) { item in
////                self.fetchCartItems()
//            }
//        }
    }
}

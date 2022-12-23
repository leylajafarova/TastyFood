//
//  DetailViewModel.swift
//  Tasty Food
//
//  Created by Leyla Jafarova on 19.12.22.
//

import Foundation

class DetailScreenViewModel {
    
    private let repo = FoodRepository()

    func addItem(item: Food, count: Int) {
        repo.addItem(item: item, orderCount: count) { item in
            print(item)
        }
    }
}

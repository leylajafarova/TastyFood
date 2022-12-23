//
//  NetworkService.swift
//  Tasty Food
//
//  Created by Leyla Jafarova on 18.12.22.
//

import Foundation
import Alamofire

enum Endpoint: String {
    case getList = "http://kasimadalan.pe.hu/foods/getAllFoods.php"
    case getCartItems = "http://kasimadalan.pe.hu/foods/getFoodsCart.php"
    case addToCart = "http://kasimadalan.pe.hu/foods/insertFood.php"
    case deleteFromCart = "http://kasimadalan.pe.hu/foods/deleteFood.php"
}

class NetworkService {
    static let userName = "leyla_jafarova"
    static let baseImageURL = "http://kasimadalan.pe.hu/foods/images/"
    
    func requestAllList(completion: @escaping ((FoodsResponse) -> Void)) {
        AF.request(Endpoint.getList.rawValue, method: .get).response {
            response in
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(FoodsResponse.self, from: data)
                    completion(result)
                }catch{
                    completion(.init(foods: []))
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    func requestAddItem(params: Parameters, completion: @escaping ((CRUDResponse?) -> Void)) {
        var newParam = params
        newParam["userName"] = NetworkService.userName
        AF.request(Endpoint.addToCart.rawValue, method: .post, parameters: newParam).response {
            response in
            if let data = response.data {
                do{
                    print(data)
                    let result = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    completion(result)
                }catch{
                    completion(nil)
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    func requestDeleteItem(params: Parameters, completion: @escaping ((CRUDResponse?) -> Void)) {
        var newParam = params
        newParam["userName"] = NetworkService.userName
        AF.request(Endpoint.deleteFromCart.rawValue, method: .post, parameters: newParam).response {
            response in
            if let data = response.data {
                do{
                    print(data)
                    let result = try JSONDecoder().decode(CRUDResponse.self, from: data)
                    completion(result)
                }catch{
                    completion(nil)
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    func requestAllCartItems(completion: @escaping ((CartItemResponse?) -> Void)) {
        let param = ["userName": NetworkService.userName]
        
        AF.request(Endpoint.getCartItems.rawValue, method: .post, parameters: param).response {
            response in
            print(response)
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(CartItemResponse.self, from: data)
                    print(result)
                    completion(result)
                }catch{
                    completion(nil)
                    print(error.localizedDescription)
                }
            }
            
        }
    }
}

//
//  Network.swift
//  K Group Challenge
//
//  Created by Ostrenkiy on 24/11/2018.
//  Copyright © 2018 Out East. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

enum DietType: Int {
    case gain = 0
    case normal = 1
    case loose = 2
}

class Network {
    static let shared = Network()
    
    let apiPath = "https://junction-kmarket.herokuapp.com/"
    
    private init() {}
    
    func getRecipes(ranks: [(item: FoodItem, rank: Int)], dietType: DietType) -> Promise<Diets> {
        return Promise { seal in
            var items = [String: Int]()
            for rank in ranks {
                if rank.rank != 0 {
                    rank.item.ids.forEach({ id in
                        items["\(id)"] = rank.rank
                    })
                }
            }
            
            let params: Parameters = [
                "preferences": items
            ]
            
            let endpoint = "recipe/recommend/"
            Alamofire.request(apiPath + endpoint, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseSwiftyJSON { response in
                switch response.result {
                case .failure(let error):
                    seal.reject(error)
                case .success(let json):
                    let diets = Diets(json: json)
                    seal.fulfill(diets)
                }
            }
        }
    }
}

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

class Network {
    static let shared = Network()
    
    let apiPath = "https://junction-kmarket.herokuapp.com/"
    
    private init() {}
    
    func getRecipes(ranks: [(item: FoodItem, rank: Int)]) -> Promise<Void> {
        return Promise { seal in
            let params: Parameters = [:]
            let endpoint = "ENDPOINT"
            Alamofire.request(apiPath + endpoint, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseSwiftyJSON { response in
                switch response.result {
                case .failure(let error):
                    seal.reject(error)
                case .success(let json):
                    seal.fulfill(())
                }
            }
        }
    }
}

//
//  ShopServices.swift
//  sample
//
//  Created by Asaph on 13/01/23.
//

import Foundation

protocol ShopServiceProtocol {
    func getShopItems(completion: @escaping (_ success: Bool, _ results: ShopItems?, _ error: String?) -> ())
}

class ShopService: ShopServiceProtocol {
    func getShopItems(completion: @escaping (Bool, ShopItems?, String?) -> ()) {
        HttpRequestHelper().GET(url: "https://run.mocky.io/v3/69ad3ec2-f663-453c-868b-513402e515f0", params: ["": ""], httpHeader: .application_json) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(ShopItems.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse ShopItems to model")
                }
            } else {
                completion(false, nil, "Error: ShopItems GET Request failed")
            }
        }
    }
}


//
//  ShopItems.swift
//  sample
//
//  Created by Asaph on 13/01/23.
//

import Foundation

struct ShopItems: Codable {
    let status: Bool
    let homeData: [HomeData]
}

struct HomeData: Codable {
    let type: String
    let values: [Value]
}

struct Value: Codable {
    let id: Int
    let name: String?
    let image_url: String?
    let banner_url: String?
    let image: String?
    let actual_price: String?
    let offer_price: String?
    let offer: Int?
    let is_express: Bool?
}

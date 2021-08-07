//
//  PriceModel.swift
//  PacketlyApp
//
//  Created by Tim on 07/08/2021.
//

import Foundation

struct PriceResponseModel: Codable {
    let error: Bool?
    let amount: Int?
    let eta: Int?
}

/*
 {
     "error": false,
     "amount": 3672,
     "eta": 3
 }
 */

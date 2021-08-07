//
//  StateModel.swift
//  PacketlyApp
//
//  Created by Tim on 07/08/2021.
//

import Foundation

struct StateRequestModel: Codable {
    let limit: Int
    let order: String
    let orderBy: String
    let country: String
}

struct StateResponseModel: Codable {
    let error: Bool?
    let msg: String?
    let data: [State?]
}

struct State: Codable {
    let city: String?
    let country: String?
    let populationCounts: [StatePopulationCounts?]
}

struct StatePopulationCounts: Codable {
    let year: String?
    let value: String?
    let sex: String?
    let reliabilty: String?
}

/*
 {
     "limit": 36,
     "order": "asc",
     "orderBy": "name",
     "country": "nigeria"
 }
 */

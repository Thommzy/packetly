//
//  Order.swift
//  PacketlyApp
//
//  Created by Tim on 07/08/2021.
//

import Foundation

struct OrderRequestModel: Codable {
    let pick_up_address: String
    let pick_up_state: String
    let drop_off_address: String
    let drop_off_state: String
    let user: String
    let rider: String
    let price: String
}

struct OrderResponseModel: Codable {
    let error: Bool?
    let message: String?
    let job: OrderJobResponseModel?
}

struct OrderJobResponseModel: Codable {
    let status: String?
    let id: String?
    let pickUpAddress: String?
    let pickUpState: String?
    let dropOffAddress: String?
    let dropOffState: String?
    let user: String?
    let price: String?
    let createdAt: String?
    let version: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case status, user, price
        case pickUpAddress = "pick_up_address"
        case pickUpState = "pick_up_state"
        case dropOffAddress = "drop_off_address"
        case dropOffState = "drop_off_state"
        case createdAt = "created_at"
        case version = "__v"
    }
}

struct OrderListRequest: Codable {
    let user: String
}

struct OrderListResponse: Codable {
    let error: Bool?
    let message: String?
    let jobs: [OrderJobResponseModel?]
}

//
//  AuthModel.swift
//  PacketlyApp
//
//  Created by Tim on 07/08/2021.
//

import Foundation

struct SignUpRequestModel: Codable {
    let email: String
    let password: String
    let phone: String
    let name: String
}

struct SignUpResponseModel: Codable {
    let error: Bool?
    let message: String?
    let success: Bool?
    let token: String?
    let user: User?
}

struct User: Codable {
    let id: String?
    let email: String?
    let name: String?
    let phone: String?
}

struct SignInRequestModel: Codable {
    let email: String
    let password: String
}

struct SignInResponseModel: Codable {
    let success: Bool?
    let token: String?
    let user: User?
}

/*
 {
     "success": true,
     "token": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMGRlYWExMGNkNWU3MDAxNTUzMGYwNyIsImVtYWlsIjoidGltb3RoeW9iZWlzdW5AZ21haWwuY29tIiwibmFtZSI6Ik9iZWlzdW4gVGltb3RoeSIsInBob25lIjoiKzIzNDgxMzMxODQ3MTciLCJpYXQiOjE2MjgzMDMwNDh9.fJscX0xtdBcA3RcunaGkowEuRkHscbIEEfCpf3z6QT0",
     "user": {
         "id": "610deaa10cd5e70015530f07",
         "email": "timothyobeisun@gmail.com",
         "name": "Obeisun Timothy",
         "phone": "+2348133184717"
     }
 }
 */
/*
 {
     "email":"timothyobeisun@gmail.com",
     "password":"tim123456"
 }
 */

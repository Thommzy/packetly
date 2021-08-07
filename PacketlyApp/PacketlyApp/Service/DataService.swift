//
//  DataService.swift
//  PacketlyApp
//
//  Created by Tim on 07/08/2021.
//

import Foundation
import Alamofire

struct DataService {
    
    // MARK: - Singleton
    static let shared = DataService()
    
    // MARK: - Services
    func requestSignIn(with data: SignInRequestModel, completion: @escaping (SignInResponseModel?, Error?) -> ()) {
        let url = "\(Constants.baseURL)/users/login"
        
        let parameters: [String: Any] = [
            "email": data.email,
            "password": data.password
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: SignInResponseModel.self) { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let result = response.value {
                completion(result, nil)
                return
            }
        }
    }
    
    func requestRegister(with data: SignUpRequestModel, completion: @escaping (SignUpResponseModel?, Error?) -> ()) {
        let url = "\(Constants.baseURL)/users/signup"
        
        let parameters: [String: Any] = [
            "email": data.email,
            "password": data.password,
            "phone": data.phone,
            "name": data.name
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: SignUpResponseModel.self) { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let result = response.value {
                completion(result, nil)
                return
            }
        }
    }
    
    func requestStates(with data: StateRequestModel, completion: @escaping(StateResponseModel?, Error?) -> ()) {
        let url = "\(Constants.stateURL)"
        
        let parameters: [String: Any] = [
            "limit": data.limit,
            "order": data.order,
            "orderBy": data.orderBy,
            "country": data.country
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: StateResponseModel?.self) {
            response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            
            if let post = response.value {
                completion(post, nil)
                return
            }
        }
    }
    
    func requestPrice(completion: @escaping(PriceResponseModel?, Error?) -> ()) {
        let url = "\(Constants.baseURL)/job/getPrice"
        
        AF.request(url, encoding: JSONEncoding.default).responseDecodable(of: PriceResponseModel?.self) {
            response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            
            if let post = response.value {
                completion(post, nil)
                return
            }
        }
    }
    
    func requestBookOrder(with data: OrderRequestModel, completion: @escaping (OrderResponseModel?, Error?) -> ()) {
        let url = "\(Constants.baseURL)/job/create"
        
        let parameters: [String: Any] = [
            "pick_up_address": data.pick_up_address,
            "pick_up_state": data.pick_up_state,
            "drop_off_address": data.drop_off_address,
            "drop_off_state": data.drop_off_state,
            "user": data.user,
            "rider": data.rider,
            "price": data.price
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: OrderResponseModel.self) { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let result = response.value {
                completion(result, nil)
                return
            }
        }
    }
    
    func requestOrderList(with data: OrderListRequest, completion: @escaping (OrderListResponse?, Error?) -> ()) {
        let url = "\(Constants.baseURL)/job/allJobs"
        
        let parameters: [String: Any] = [
            "user": data.user
        ]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: OrderListResponse.self) { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let result = response.value {
                completion(result, nil)
                return
            }
        }
    }

    
    
}

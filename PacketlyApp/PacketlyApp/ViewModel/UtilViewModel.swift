//
//  UtilViewModel.swift
//  PacketlyApp
//
//  Created by Tim on 07/08/2021.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyUserDefaults

class UtilViewModel {
    
    let priceResult: BehaviorRelay<PriceResponseModel?> = BehaviorRelay(value: nil)
    let orderResult: BehaviorRelay<OrderResponseModel?> = BehaviorRelay(value: nil)
    let orderListResult: BehaviorRelay<OrderListResponse?> = BehaviorRelay(value: nil)
    let error: BehaviorRelay<Error?> = BehaviorRelay(value: nil)
    
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    private var dataService: DataService?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    init(dataService: DataService) {
        self.dataService = dataService
    }
    
    // MARK: - Network call
    func doPrice() {
        self.dataService?.requestPrice(completion: { (result, error) in
            if let error = error {
                self.error.accept(error)
                self.isLoading = false
                return
            }
            self.error.accept(nil)
            self.isLoading = false
            self.priceResult.accept(result)
        })
    }
    
    func doOrder(with data: OrderRequestModel) {
        self.dataService?.requestBookOrder(with: data, completion: { (result, error) in
            if let error = error {
                self.error.accept(error)
                self.isLoading = false
                return
            }
            self.error.accept(nil)
            self.isLoading = false
            self.orderResult.accept(result)
        })
    }
    
    func doOrderList(with data: OrderListRequest) {
        self.dataService?.requestOrderList(with: data, completion: { (result, error) in
            if let error = error {
                self.error.accept(error)
                self.isLoading = false
                return
            }
            self.error.accept(nil)
            self.isLoading = false
            self.orderListResult.accept(result)
        })
    }
}

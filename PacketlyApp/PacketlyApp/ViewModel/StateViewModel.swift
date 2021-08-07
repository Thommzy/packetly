//
//  StateViewModel.swift
//  PacketlyApp
//
//  Created by Tim on 07/08/2021.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyUserDefaults

class StateViewModel {
    
    let stateResult: BehaviorRelay<StateResponseModel?> = BehaviorRelay(value: nil)
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
    func doState(with data: StateRequestModel) {
        self.dataService?.requestStates(with: data, completion: { (result, error) in
            if let error = error {
                self.error.accept(error)
                self.isLoading = false
                return
            }
            self.error.accept(nil)
            self.isLoading = false
            self.stateResult.accept(result)
        })
    }
}

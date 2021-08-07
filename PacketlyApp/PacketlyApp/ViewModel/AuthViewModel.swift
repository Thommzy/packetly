//
//  AuthViewModel.swift
//  PacketlyApp
//
//  Created by Tim on 07/08/2021.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyUserDefaults

class AuthViewModel {
    
    let authResult: BehaviorRelay<SignUpResponseModel?> = BehaviorRelay(value: nil)
    let signInResult: BehaviorRelay<SignInResponseModel?> = BehaviorRelay(value: nil)
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
    func doRegister(with data: SignUpRequestModel) {
        self.dataService?.requestRegister(with: data, completion: { (result , error) in
            if let error = error {
                self.error.accept(error)
                self.isLoading = false
                return
            }
            self.error.accept(nil)
            self.isLoading = false
            self.authResult.accept(result)
        })
    }
    
    func doSignIn(with data: SignInRequestModel) {
        self.dataService?.requestSignIn(with: data, completion: { (result, error) in
            if let error = error {
                self.error.accept(error)
                self.isLoading = false
                return
            }
            self.error.accept(nil)
            self.isLoading = false
            self.signInResult.accept(result)
        })
    }
}

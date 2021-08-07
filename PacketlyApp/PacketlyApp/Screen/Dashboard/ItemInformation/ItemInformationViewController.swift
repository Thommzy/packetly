//
//  ItemInformationViewController.swift
//  PacketlyApp
//
//  Created by Tim on 06/08/2021.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import SwiftyUserDefaults

class ItemInformationViewController: UIViewController {
    
    @IBOutlet weak var pickupStateTxtField: UITextField!
    @IBOutlet weak var pickupAddressTxtField: UITextField!
    @IBOutlet weak var dropOffStateTxtField: UITextField!
    @IBOutlet weak var DropOffStateAddress: UITextField!
    var pickupStatePickerView: UIPickerView = UIPickerView()
    var dropOffStatePickerView: UIPickerView = UIPickerView()
    @IBOutlet weak var priceParentView: UIView!
    @IBOutlet weak var priceStackView: UIStackView!
    @IBOutlet weak var bookParentView: UIView!
    @IBOutlet weak var bookButtonParentView: UIView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var etaLbl: UILabel!
    @IBOutlet weak var bookBtn: UIButton!
    
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let stateViewModel = StateViewModel(dataService: DataService())
    let utilViewModel = UtilViewModel(dataService: DataService())
    private let disposedBag = DisposeBag()
    
    var stateArray: [String] = []
    var defaultSavedState: [String] = ["Select State"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultSavedState += Defaults[\.savedStateArray]
        setup()
        setupPickupStateTxtField()
        setupDropOffStateTxtField()
        setupStateResponse()
        setupPriceResponse()
        setupHideLowerView()
    }
    
    func setupLoaderParentView() {
        priceParentView.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(priceParentView)
            make.centerY.equalTo(priceParentView)
        }
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.startAnimating()
    }
    
    func setupDropOffStateTxtField() {
        dropOffStatePickerView.delegate = self
        dropOffStateTxtField.inputView = dropOffStatePickerView
    }
    
    func setupPickupStateTxtField() {
        pickupStatePickerView.delegate = self
        pickupStateTxtField.inputView = pickupStatePickerView
    }
    
    func setup() {
        title = "Item Information"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 25, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.systemBlue ]
    }
    
    func setupHideLowerView() {
        priceStackView.isHidden = true
        bookButtonParentView.isHidden = true
    }
    
    func setupShowLowerView() {
        priceStackView.isHidden = false
        bookButtonParentView.isHidden = false
    }
    
    @IBAction func bookBtnActn(_ sender: UIButton) {
        setupLoaderParentView()
        let pickupAddress = pickupAddressTxtField.text ?? String()
        let pickupState = pickupStateTxtField.text ?? String()
        let dropOffAddress = DropOffStateAddress.text ?? String()
        let dropOffState = dropOffStateTxtField.text ?? String()
        let user = Defaults[\.savedUserId]
        let rider = "610d91b5d6cfdcfbd5701d9e"
        let price = priceLbl.text?.filter({ (txt) -> Bool in
            return txt != "₦"
        }) ?? String()
        let data = OrderRequestModel(pick_up_address: pickupAddress, pick_up_state: pickupState, drop_off_address: dropOffAddress, drop_off_state: dropOffState, user: user, rider: rider, price: price)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let itemInfoVc = storyBoard.instantiateViewController(identifier: "AccountDetailsViewController") as! AccountDetailsViewController
        itemInfoVc.orderData = data
        self.navigationController?.pushViewController(itemInfoVc, animated: true)
    }
    
}

extension ItemInformationViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return defaultSavedState.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case pickupStatePickerView:
            print(defaultSavedState[row], "sonsks")
            if defaultSavedState[row] == "Select State" {
                pickupStateTxtField.text = ""
                setupHideLowerView()
            } else {
                pickupStateTxtField.text = defaultSavedState[row]
                if dropOffStateTxtField.text != "" {
                    setupHideLowerView()
                    setupLoaderParentView()
                    dismissKeyboard()
                    utilViewModel.doPrice()
                }
            }
        default:
            if defaultSavedState[row] == "Select State" {
                dropOffStateTxtField.text = ""
                setupHideLowerView()
            } else {
                dropOffStateTxtField.text = defaultSavedState[row]
                if pickupStateTxtField.text != "" {
                    setupHideLowerView()
                    setupLoaderParentView()
                    dismissKeyboard()
                    utilViewModel.doPrice()
                }
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case pickupStatePickerView:
            return defaultSavedState[row]
        default:
            return defaultSavedState[row]
        }
    }
}


extension ItemInformationViewController {
    func setupStateResponse() {
        stateViewModel.stateResult.asObservable()
            .subscribe(onNext: { [weak self]
                result in
                if let result = result {
                    let arr = result.data.map{($0?.city ?? String())}
                    self?.stateArray += arr
                    Defaults[\.savedStateArray] += arr
                    self?.defaultSavedState += Defaults[\.savedStateArray]
                    print(result, "Result:::")
                }
            })
            .disposed(by: disposedBag)
        stateViewModel.error.asObservable()
            .subscribe(onNext: { [weak self]
                error in
                if error != nil {
                    
                    self?.toast(to: error?.localizedDescription ?? String())
                }
            })
            .disposed(by: disposedBag)
        let data = StateRequestModel(limit: 36, order: "asc", orderBy: "name", country: "nigeria")
        stateViewModel.doState(with: data)
    }
    
    func setupPriceResponse() {
        utilViewModel.priceResult.asObservable()
            .subscribe(onNext: { [weak self]
                result in
                if let result = result {
                    print(result)
                    if result.error == false {
                        self?.priceLbl.text = "₦\(result.amount ?? Int())"
                        self?.etaLbl.text = "\(result.eta ?? Int())"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            self?.loadingIndicator.stopAnimating()
                            self?.setupShowLowerView()
                        }
                    }
                }
            })
            .disposed(by: disposedBag)
        utilViewModel.error.asObservable()
            .subscribe(onNext: { [weak self]
                error in
                if error != nil {
                    
                    self?.toast(to: error?.localizedDescription ?? String())
                }
            })
            .disposed(by: disposedBag)
    }
}

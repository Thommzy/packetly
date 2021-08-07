//
//  AccountDetailsViewController.swift
//  PacketlyApp
//
//  Created by Tim on 05/08/2021.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import SwiftyUserDefaults

class AccountDetailsViewController: UIViewController {
    
    @IBOutlet weak var visaCardParentView: UIView!
    @IBOutlet weak var masterCardParentView: UIView!
    @IBOutlet weak var radioParentView: UIView!
    @IBOutlet weak var radioSemiView: UIView!
    @IBOutlet weak var radioInnerView: UIView!
    @IBOutlet weak var masterCardRadioParentView: UIView!
    @IBOutlet weak var masterCardRadioSemiView: UIView!
    @IBOutlet weak var masterCardRadioInnerView: UIView!
    @IBOutlet weak var payWIthCardView: UIView!
    @IBOutlet weak var walletView: UIView!
    @IBOutlet weak var walletInfoLbl: UILabel!
    @IBOutlet weak var cardInfoLbl: UILabel!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var cardParentView: UIView!
    @IBOutlet weak var walletParentView: UIView!
    @IBOutlet weak var cardLblParentView: UIView!
    @IBOutlet weak var finishBtn: UIButton!
    
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let utilViewModel = UtilViewModel(dataService: DataService())
    private let disposedBag = DisposeBag()
    var orderData: OrderRequestModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupHideViewByDefault()
        setupVisaCardParentView()
        setupMasterCardParentView()
        setupMasterCardRadioView()
        
        setupBookOrderResponse()
    }
    
    func setupHideViewByDefault() {
        walletView.isHidden = true
        walletParentView.isHidden = true
    }
    
    func setupLoaderParentView() {
        view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
        }
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.startAnimating()
    }
    
    func setupVisaCardParentView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(visaCardParentViewTapped))
        visaCardParentView.isUserInteractionEnabled = true
        visaCardParentView.addGestureRecognizer(tap)
    }
    
    @objc func visaCardParentViewTapped() {
        radioInnerView.backgroundColor = .systemBlue
        masterCardRadioInnerView.backgroundColor = .white
        cardParentView.isHidden = false
        cardLblParentView.isHidden = false
        walletView.isHidden = true
        walletParentView.isHidden = true
    }
    
    func setupMasterCardParentView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(masterCardParentViewTapped))
        masterCardParentView.isUserInteractionEnabled = true
        masterCardParentView.addGestureRecognizer(tap)
        masterCardParentView.addTopBorderWithColor(color: .gray, width: 0.3)
    }
    
    @objc func masterCardParentViewTapped() {
        radioInnerView.backgroundColor = .white
        masterCardRadioInnerView.backgroundColor = .systemBlue
        cardParentView.isHidden = true
        cardLblParentView.isHidden = true
        walletView.isHidden = false
        walletParentView.isHidden = false
    }
    
    func setupMasterCardRadioView() {
        masterCardRadioInnerView.backgroundColor = .white
    }
    
    func setup() {
        title = "Enter Details"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 25, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
    }
    
    
    @IBAction func finishBtnAction(_ sender: UIButton) {
        setupLoaderParentView()
        utilViewModel.doOrder(with: orderData!)
    }
    
    func moveToCongratulationScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let congatulationsVc = storyBoard.instantiateViewController(identifier: "CongratulationsViewController") as! CongratulationsViewController
        congatulationsVc.modalPresentationStyle = .fullScreen
        congatulationsVc.modalTransitionStyle = .crossDissolve
        self.present(congatulationsVc, animated: true, completion: nil)
    }
    
}

extension AccountDetailsViewController {
    func setupBookOrderResponse() {
        utilViewModel.orderResult.asObservable()
            .subscribe(onNext: { [ weak self ]
                result in
                if let result = result {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self?.loadingIndicator.stopAnimating()
                        self?.moveToCongratulationScreen()
                    }
                    print(result)
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

//
//  AccountDetailsViewController.swift
//  PacketlyApp
//
//  Created by Tim on 05/08/2021.
//

import UIKit

class AccountDetailsViewController: UIViewController {
    
    @IBOutlet weak var visaCardParentView: UIView!
    @IBOutlet weak var masterCardParentView: UIView!
    @IBOutlet weak var radioParentView: UIView!
    @IBOutlet weak var radioSemiView: UIView!
    @IBOutlet weak var radioInnerView: UIView!
    @IBOutlet weak var masterCardRadioParentView: UIView!
    @IBOutlet weak var masterCardRadioSemiView: UIView!
    @IBOutlet weak var masterCardRadioInnerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupVisaCardParentView()
        setupMasterCardParentView()
        setupMasterCardRadioView()
    }
    
    func setupVisaCardParentView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(visaCardParentViewTapped))
        visaCardParentView.isUserInteractionEnabled = true
        visaCardParentView.addGestureRecognizer(tap)
    }
    
    @objc func visaCardParentViewTapped() {
        radioInnerView.backgroundColor = .systemBlue
        masterCardRadioInnerView.backgroundColor = .white
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
    }
    
    func setupMasterCardRadioView() {
        masterCardRadioInnerView.backgroundColor = .white
    }
    
    func setup() {
        title = "Enter Details"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 25, weight: .bold), NSAttributedString.Key.foregroundColor: .systemBlue ?? UIColor()]
    }
}

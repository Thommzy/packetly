//
//  OrderDetailViewController.swift
//  PacketlyApp
//
//  Created by Tim on 06/08/2021.
//

import UIKit

class OrderDetailViewController: UIViewController {

    @IBOutlet weak var dateLbl: UILabel!
    var orderDetails: OrderJobResponseModel?
    
    @IBOutlet weak var pickupAdressLbl: UILabel!
    @IBOutlet weak var pickupStateLbl: UILabel!
    @IBOutlet weak var dropOffAddressLbl: UILabel!
    @IBOutlet weak var dropOffStateLbl: UILabel!
    @IBOutlet weak var riderLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setupDetails()
        
    }
    
    func setupDetails() {
        pickupAdressLbl.text = orderDetails?.pickUpAddress
        pickupStateLbl.text = orderDetails?.pickUpState
        dropOffAddressLbl.text = orderDetails?.dropOffAddress
        dropOffStateLbl.text = orderDetails?.dropOffState
        riderLbl.text = "Unknown"
        amountLbl.text = "₦\(orderDetails?.price ?? String())"
        statusLbl.text = orderDetails?.status
    }
    
    func setup() {
        title = "Order Detail"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 25, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.systemBlue ]
    }
}

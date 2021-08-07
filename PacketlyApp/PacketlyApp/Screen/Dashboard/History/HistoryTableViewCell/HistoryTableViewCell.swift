//
//  HistoryTableViewCell.swift
//  PacketlyApp
//
//  Created by Tim on 06/08/2021.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var destinationAddressLbl: UILabel!
    @IBOutlet weak var pendingLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    let identifier = String(describing: HistoryTableViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var order: OrderJobResponseModel? {
        didSet {
            amountLbl.text = order?.price
            destinationAddressLbl.text = order?.dropOffAddress
            pendingLbl.text = order?.status
            let date = order?.createdAt?.dropLast(14)
            dateLbl.text = String(date ?? "")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

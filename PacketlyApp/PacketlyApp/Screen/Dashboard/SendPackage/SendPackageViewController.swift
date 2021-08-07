//
//  SendPackageViewController.swift
//  PacketlyApp
//
//  Created by Tim on 06/08/2021.
//

import UIKit
import SwiftyUserDefaults

class SendPackageViewController: UIViewController {
    @IBOutlet weak var lorryBtn: UIButton!
    
    @IBOutlet weak var vanBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    @IBAction func vanBtnAction(_ sender: UIButton) {
        Defaults[\.isVan] = true
        Defaults[\.isLorry] = false
        moveToItemInfoScreen()
    }
    
    @IBAction func lorryBtnAction(_ sender: UIButton) {
        Defaults[\.isLorry] = true
        Defaults[\.isVan] = false
        moveToItemInfoScreen()
    }
    
    func moveToItemInfoScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
        let itemInfoVc = storyBoard.instantiateViewController(identifier: "ItemInformationViewController") as! ItemInformationViewController
        self.navigationController?.pushViewController(itemInfoVc, animated: true)
    }
    
    func setup() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
}

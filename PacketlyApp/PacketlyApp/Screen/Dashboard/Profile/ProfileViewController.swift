//
//  ProfileViewController.swift
//  PacketlyApp
//
//  Created by Tim on 07/08/2021.
//

import UIKit
import SwiftyUserDefaults

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePhoneNumberLbl: UILabel!
    @IBOutlet weak var profileFullNameLbl: UILabel!
    @IBOutlet weak var profileEmailLbl: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupProfileDetails()
    }
    
    func setupProfileDetails() {
        profilePhoneNumberLbl.text = Defaults[\.savedUserPhoneNumber]
        profileEmailLbl.text = Defaults[\.savedUserEmail]
        profileFullNameLbl.text = Defaults[\.savedUserFullName]
    }
    
    @IBAction func logoutBtnAction(_ sender: UIButton) {
        Defaults[\.isLoggedIn] = false
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let congatulationsVc = storyBoard.instantiateViewController(identifier: "SignInViewController") as! SignInViewController
        congatulationsVc.modalPresentationStyle = .fullScreen
        congatulationsVc.modalTransitionStyle = .crossDissolve
        self.present(congatulationsVc, animated: true, completion: nil)
    }
}

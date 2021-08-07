//
//  CongratulationsViewController.swift
//  PacketlyApp
//
//  Created by Tim on 06/08/2021.
//

import UIKit

class CongratulationsViewController: UIViewController {
    
    @IBOutlet weak var getStartedBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func getStartedBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
         let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive
                        || $0.activationState == .background
                        || $0.activationState == .foregroundInactive
                        || $0.activationState == .unattached})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        guard let window = keyWindow else { return }
        let tabBar = window.rootViewController as? UITabBarController
        tabBar?.selectedIndex = 1
    }
}

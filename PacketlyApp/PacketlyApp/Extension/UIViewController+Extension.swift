//
//  UIViewController+Extension.swift
//  PacketlyApp
//
//  Created by Tim on 07/08/2021.
//

import UIKit
import Toast_Swift

extension UIViewController {
    open func toast(to message: String) {
        let style = ToastStyle()
        // present the toast with the new style
        self.view.makeToast(message, duration: 3.0, position: .bottom, style: style)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


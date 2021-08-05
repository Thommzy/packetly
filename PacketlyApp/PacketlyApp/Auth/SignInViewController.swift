//
//  SignInViewController.swift
//  PacketlyApp
//
//  Created by Tim on 04/08/2021.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var signinBorderView: UIView!
    @IBOutlet weak var signupBorderView: UIView!
    @IBOutlet weak var signInParentView: UIView!
    @IBOutlet weak var signUpParentView: UIView!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var phoneNumberTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var fullNameTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signinBorderView.backgroundColor = .systemGray4
        signInParentView.isHidden = true
        signUpParentView.isHidden = false
    }
    
    @IBAction func signinAction(_ sender: UIButton) {
        signinBorderView.backgroundColor = .white
        signupBorderView.backgroundColor = .systemGray4
        signInParentView.isHidden = false
        signUpParentView.isHidden = true
    }
    
    @IBAction func signupAction(_ sender: UIButton) {
        signinBorderView.backgroundColor = .systemGray4
        signupBorderView.backgroundColor = .white
        signInParentView.isHidden = true
        signUpParentView.isHidden = false
    }
    
    @IBAction func createAccountBtnAction(_ sender: UIButton) {
        
    }
}

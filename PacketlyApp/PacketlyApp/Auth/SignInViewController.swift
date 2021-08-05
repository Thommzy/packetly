//
//  SignInViewController.swift
//  PacketlyApp
//
//  Created by Tim on 04/08/2021.
//

import UIKit
import SnapKit

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
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var scrollInerView: UIView!
    
    
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        signinBorderView.backgroundColor = .systemGray4
        signInParentView.isHidden = true
        signUpParentView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupLoaderParentView() {
        scrollInerView.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(scrollInerView)
            make.centerY.equalTo(scrollInerView)
        }
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.startAnimating()
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
    
    @IBAction func signInBtnAction(_ sender: Any) {
        setupLoaderParentView()
        signInBtn.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.5)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.signInBtn.backgroundColor = UIColor.systemBlue
            self.loadingIndicator.stopAnimating()
            self.moveToAccountDetailsScreen()
        }
    }
    
    func moveToAccountDetailsScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let accountVc = storyBoard.instantiateViewController(identifier: "AccountDetailsViewController") as! AccountDetailsViewController
        self.navigationController?.pushViewController(accountVc, animated: true)
    }
}

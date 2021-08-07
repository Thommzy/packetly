//
//  SignInViewController.swift
//  PacketlyApp
//
//  Created by Tim on 04/08/2021.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import SwiftyUserDefaults

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
    @IBOutlet weak var fullNameTxtField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var scrollInerView: UIView!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var signInEmailTextField: UITextField!
    @IBOutlet weak var signInPasswordTextField: UITextField!
    
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    let authViewModel = AuthViewModel(dataService: DataService())
    private let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        setupCheckLoggedIn()
        signinBorderView.backgroundColor = .systemGray4
        signInParentView.isHidden = true
        signUpParentView.isHidden = false
        setupSignUpResponse()
        setupSignInResponse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupCheckLoggedIn() {
        print(Defaults[\.isLoggedIn], "::::")
        if Defaults[\.isLoggedIn] == true {
            moveToDashboardScreen()
        }
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
        signInTabAction()
    }
    
    @IBAction func signupAction(_ sender: UIButton) {
        signinBorderView.backgroundColor = .systemGray4
        signupBorderView.backgroundColor = .white
        signInParentView.isHidden = true
        signUpParentView.isHidden = false
    }
    
    @IBAction func createAccountBtnAction(_ sender: UIButton) {
        authButtonAction()
        dismissKeyboard()
        let email = emailTxtField.text ?? String()
        let password = passwordTxtField.text ?? String()
        let phone = phoneNumberTxtField.text ?? String()
        let name = fullNameTxtField.text ?? String()
        let confirmPassword = confirmPasswordTxtField.text ?? String()
        if phone.count < 10 {
            toast(to: "Please Input Phone Number")
            afterAuthBtnAction()
        } else if password != confirmPassword {
            toast(to: "Password does not Match")
            afterAuthBtnAction()
        } else if !email.isValidEmail() {
            toast(to: "Invalid Email")
            afterAuthBtnAction()
        } else {
            let data = SignUpRequestModel(email: email, password: password, phone: phone, name: name)
            authViewModel.doRegister(with: data)
        }
    }
    
    @IBAction func signInBtnAction(_ sender: Any) {
        authButtonAction()
        dismissKeyboard()
        let email = signInEmailTextField.text ?? String()
        let password = signInPasswordTextField.text ?? String()
        let data = SignInRequestModel(email: email, password: password)
        authViewModel.doSignIn(with: data)
    }
    
    func moveToAccountDetailsScreen() {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let accountVc = storyBoard.instantiateViewController(identifier: "AccountDetailsViewController") as! AccountDetailsViewController
        self.navigationController?.pushViewController(accountVc, animated: true)
    }
    
    func moveToDashboardScreen() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Dashboard", bundle:nil)
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardTabBarID") as? UITabBarController
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
    
    func signInTabAction() {
        signinBorderView.backgroundColor = .white
        signupBorderView.backgroundColor = .systemGray4
        signInParentView.isHidden = false
        signUpParentView.isHidden = true
    }
    
    func authButtonAction() {
        signInBtn.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.5)
        signupBtn.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.5)
        setupLoaderParentView()
    }
    
    func afterAuthBtnAction() {
        signInBtn.backgroundColor = UIColor.systemBlue
        signupBtn.backgroundColor = UIColor.systemBlue
        loadingIndicator.stopAnimating()
    }
    
    func emptySignUpTextFields() {
        fullNameTxtField.text = ""
        emailTxtField.text = ""
        phoneNumberTxtField.text = ""
        passwordTxtField.text = ""
        confirmPasswordTxtField.text = ""
    }
}

//Api Calls
extension SignInViewController {
    func setupSignUpResponse() {
        authViewModel.authResult.asObservable()
            .subscribe(onNext: { [weak self]
                result in
                self?.afterAuthBtnAction()
                if let result = result {
                    if result.error != false {
                        self?.toast(to: result.message ?? String())
                    }
                    if result.message == "signup is successful" {
                        self?.toast(to: result.message ?? String())
                        self?.emptySignUpTextFields()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self?.signInTabAction()
                        }
                    }
                }
            })
            .disposed(by: disposedBag)
        authViewModel.error.asObservable()
            .subscribe(onNext: { [weak self]
                error in
                if error != nil {
                    self?.afterAuthBtnAction()
                    self?.toast(to: error?.localizedDescription ?? String())
                }
            })
            .disposed(by: disposedBag)
    }
    
    func setupSignInResponse() {
        authViewModel.signInResult.asObservable()
            .subscribe(onNext: { [weak self]
                result in
                self?.afterAuthBtnAction()
                if let result = result {
                    if result.success == nil {
                        self?.toast(to: "Incorrect User Details")
                    }
                    if result.success == true {
                        Defaults[\.isLoggedIn] = true
                        Defaults[\.savedUserId] = result.user?.id ?? String()
                        Defaults[\.savedUserEmail] = result.user?.email ?? String()
                        Defaults[\.savedUserFullName] = result.user?.name ?? String()
                        Defaults[\.savedUserPhoneNumber] = result.user?.phone ?? String()
                        self?.toast(to: "Login Successful!")
                        self?.moveToDashboardScreen()
                        
                    }
                    print(result, ":::Result>>>")
                }
            })
            .disposed(by: disposedBag)
        authViewModel.error.asObservable()
            .subscribe(onNext: { [weak self]
                error in
                if error != nil {
                    self?.afterAuthBtnAction()
                    self?.toast(to: error?.localizedDescription ?? String())
                }
            })
            .disposed(by: disposedBag)
        
    }
}

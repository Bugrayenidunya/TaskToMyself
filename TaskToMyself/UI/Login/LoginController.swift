//
//  LoginViewController.swift
//  TaskToMyself
//
//  Created by Bugra's Mac on 9.09.2020.
//  Copyright © 2020 Bugra. All rights reserved.
//

import Firebase
import UIKit

class LoginController: UIViewController {
    
    let viewModel = LoginViewModel()
    
    // MARK: Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2352941176, green: 0.1607843137, blue: 0.2745098039, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loginButton.layer.cornerRadius = Constant.UIConstant.buttonCornerRadius
    }
    
    // MARK: Actions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        viewModel.loginFirebase(user: User(email: email, password: password)) { (result) in
            switch result {
            case .success(let loggedinUser):
                self.performSegue(withIdentifier: Constant.SegueConstant.loginToHome, sender: self)
                print("User Logged in with email: \(loggedinUser.email)")
            case .failure(let error):
                if error == .generalError {
                    print("General Error occured while login: \(error). File: \(#file), Line: \(#line)")
                }
            }
        }
    }
    
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

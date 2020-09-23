//
//  RegisterViewController.swift
//  TaskToMyself
//
//  Created by Bugra's Mac on 9.09.2020.
//  Copyright © 2020 Bugra. All rights reserved.
//

import Firebase
import UIKit

class RegisterController: UIViewController {
    
    let viewModel = RegisterViewModel()
    
    // MARK: Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2352941176, green: 0.1607843137, blue: 0.2745098039, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        registerButton.layer.cornerRadius = Constant.UIConstant.buttonCornerRadius
    }
    
    // MARK:  Actions
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        viewModel.registerFirebase(user: User(email: email, password: password)) { (result) in
            switch result {
            case .success(let registeredUser):
                self.performSegue(withIdentifier: Constant.SegueConstant.registerToHome, sender: self)
                print("Register is completed with: \(registeredUser.email)")
            case .failure(let error):
                if error == .generalError {
                    print("General Error occured while trying to Register: \(error). File: \(#file), Line: \(#line)")
                }
            }
        }
    }
    
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

//
//  WelcomeController.swift
//  TaskToMyself
//
//  Created by Bugra's Mac on 9.09.2020.
//  Copyright © 2020 Bugra. All rights reserved.
//

import Firebase
import UIKit

class WelcomeController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loginButton.layer.cornerRadius = Constant.UIConstant.buttonCornerRadius
        registerButton.layer.cornerRadius = Constant.UIConstant.buttonCornerRadius
    }
    
}

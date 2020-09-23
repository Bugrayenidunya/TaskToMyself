//
//  LoginViewModel.swift
//  TaskToMyself
//
//  Created by Bugra's Mac on 18.09.2020.
//  Copyright © 2020 Bugra. All rights reserved.
//

import Firebase

class LoginViewModel {
    
    func loginFirebase(user: User, completion: @escaping(Swift.Result<User, LoginError>) -> Void) {
        
        Auth.auth().signIn(withEmail: user.email, password: user.password) { authResult, error in
            if let error = error {
                print(error)
                completion(Swift.Result.failure(LoginError.generalError))
                return
            }
            completion(Swift.Result.success(user))
        }
    }
}

//
//  RegisterViewModel.swift
//  TaskToMyself
//
//  Created by Bugra's Mac on 18.09.2020.
//  Copyright © 2020 Bugra. All rights reserved.
//

import Firebase

class RegisterViewModel {
    
    func registerFirebase (user: User, completion: @escaping(Swift.Result<User, RegisterError>) -> Void) {
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
            if let error = error {
                print(error)
                completion(Swift.Result.failure(RegisterError.generalError))
                return
            }
            completion(Swift.Result.success(user))
        }
    }
}

//
//  LoginError.swift
//  TaskToMyself
//
//  Created by Bugra's Mac on 21.09.2020.
//  Copyright © 2020 Bugra. All rights reserved.
//

import Foundation

enum LoginError: Error {
    case generalError
    case invalidEmail
    case invalidPassword
}

//
//  User.swift
//  UCU_iOS_app_Architectures
//
//  Created by Roxane Gud on 4/27/20.
//  Copyright © 2020 Roxane Markhyvka. All rights reserved.
//

import Foundation

final class User {
    let userId: String
    
    var firstName: String?
    var lastName: String?
    var avatarURL: String?
    var city: String?
    var country: String?
    
    var dateJoined: Date?
    
    init(userId: String) {
        self.userId = userId
    }
}

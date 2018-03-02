//
//  User.swift
//  MyChat Dev
//
//  Created by Jakub Vodak on 01/03/2018.
//  Copyright © 2018 Jakub Vodak. All rights reserved.
//

import Foundation

class User {

    let name: String

    init(name: String) {

        self.name = name
    }

    init?(json: [String:Any]) {

        if let senderName = json["name"] as? String {

            self.name = senderName
        }
        else {

            return nil
        }
    }
}

//
//  Message.swift
//  MyChat
//
//  Created by Jakub Vodak on 01/03/2018.
//  Copyright © 2018 Jakub Vodak. All rights reserved.
//

import Foundation

class Message {

    let text: String
    let sender: User

    var dictionaryValue: NSDictionary {
        get {
            return ["text": text, "sender": ["name": sender.name]]
        }
    }

    init(text: String, sender: User) {

        self.text = text
        self.sender = sender
    }
}

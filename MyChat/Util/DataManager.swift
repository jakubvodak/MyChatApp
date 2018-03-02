//
//  DataManager.swift
//  MyChat
//
//  Created by Jakub Vodak on 02/03/2018.
//  Copyright © 2018 Jakub Vodak. All rights reserved.
//

import Foundation
import FirebaseDatabase

protocol DataManagerDelegate: NSObjectProtocol {

    func dataManagerDidReceiveNewData(_ manager: DataManager)
}

class DataManager {

    weak var delagete: DataManagerDelegate?

    var messages = [Message]()


    init() {

        watchForUpdates()
    }

    func watchForUpdates() {

        Database.database().reference(withPath: "Messages").observe(.value) { (snapshot) in

            self.parseData(snapshot)
        }
    }

    func parseData(_ data: DataSnapshot) {

        messages.removeAll()

        for dictionary in data.children.allObjects {

            if let json = dictionary as? DataSnapshot,
                let messageJson = json.value as? [String: Any],
                let messageText = messageJson["text"] as? String,
                let senderJson =  messageJson["sender"] as? [String: Any],
                let senderName = senderJson["name"] as? String {

                let message = Message(text: messageText, sender: User(name: senderName))
                messages.append(message)
            }
        }

        messages.reverse()

        delagete?.dataManagerDidReceiveNewData(self)
    }


    func sendMessage(_ message: Message) {

        let trigger = Database.database().reference(withPath: "Messages").childByAutoId()
        trigger.setValue(message.dictionaryValue)
    }
}

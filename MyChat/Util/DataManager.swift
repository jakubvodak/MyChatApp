//
//  DataManager.swift
//  MyChat
//
//  Created by Jakub Vodak on 02/03/2018.
//  Copyright © 2018 Jakub Vodak. All rights reserved.
//

import Foundation

protocol DataManagerDelegate: NSObjectProtocol {

    func dataManagerDidReceiveNewData(_ manager: DataManager)
}

class DataManager {

    weak var delagete: DataManagerDelegate?

    var messages = [Message]()


    init() {

    }

    func sendMessage(_ message: Message) {

        messages.insert(message, at: 0)
        delagete?.dataManagerDidReceiveNewData(self)
    }
}

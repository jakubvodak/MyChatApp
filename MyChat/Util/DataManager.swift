//
//  DataManager.swift
//  MyChat
//
//  Created by Jakub Vodak on 02/03/2018.
//  Copyright © 2018 Jakub Vodak. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Alamofire

protocol DataManagerDelegate: NSObjectProtocol {

    func dataManagerDidReceiveNewData(_ manager: DataManager)
    func dataManagerDidFailWithError(_ error: Error)
}

class DataManager {

    weak var delagete: DataManagerDelegate?

    var messages = [Message]()


    init() {

        //watchForUpdates()
    }

    func watchForUpdates() {

        Database.database().reference(withPath: "Messages").observe(.childAdded) { (snapshot) in

            self.parseData(snapshot)
        }
    }

    func parseData(_ snapshot: DataSnapshot) {

        if let json = snapshot.value as? [String: Any],
            let message = Message(json: json) {

            messages.append(message)
        }

        delagete?.dataManagerDidReceiveNewData(self)
    }


    func sendMessage(_ message: Message) {

        let trigger = Database.database().reference(withPath: "Messages").childByAutoId()
        trigger.setValue(message.dictionaryValue)
    }


    // MARK: - API Requests

    func getDataFromAPI() {

        Alamofire.request(URL(string: "http://private-6c237c-tehatapp.apiary-mock.com/messages")!, method: .get)
            .responseJSON { (response) in

                switch response.result {
                case .success(let json):

                    if let validJson = json as? [[String:AnyObject]] {
                        for item in validJson {
                            if let message = Message(json: item) {
                                self.messages.append(message)
                            }
                        }
                    }

                    self.delagete?.dataManagerDidReceiveNewData(self)
                    self.watchForUpdates()

                case .failure(let error):
                    self.delagete?.dataManagerDidFailWithError(error)
                    //print("Request failed with error: \(error)")
                }
        }
    }
}

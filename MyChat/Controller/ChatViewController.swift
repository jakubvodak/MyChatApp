//
//  ChatViewController.swift
//  MyChat
//
//  Created by Jakub Vodak on 01/03/2018.
//  Copyright © 2018 Jakub Vodak. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Data

    var me: User!
    var messages = [Message]()


    // MARK: - Outlets

    @IBOutlet var txtMessage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = me.name

        mockData()
        applyAppearance()
    }

    deinit {
        print("Good bye")
    }

    // MARK: - Appearance

    func applyAppearance() {


    }

    // MARK: - Func

    @IBAction func sendMessage() {

        if let message = txtMessage.text, !message.isEmpty {

            print(message)
            //TODO: send(message)
            txtMessage.text = nil
        }
    }

    // MARK: - TextField

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        txtMessage.resignFirstResponder()

        return false
    }

    func mockData() {

        let message1 = Message(text: "Ahoooj!", sender: User(name: "Jakub"))
        let message2 = Message(text: "Nazdáááár!", sender: User(name: "Pepa"))

        messages = [message1, message2]
    }

}

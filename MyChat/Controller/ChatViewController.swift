//
//  ChatViewController.swift
//  MyChat
//
//  Created by Jakub Vodak on 01/03/2018.
//  Copyright © 2018 Jakub Vodak. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, DataManagerDelegate {

    // MARK: - Data

    var me: User!
    var dataManager: DataManager!

    // MARK: - Outlets

    @IBOutlet var txtMessage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomTableViewConstraint: NSLayoutConstraint!

    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataManager = DataManager()
        self.dataManager.delagete = self

        self.title = me.name

        applyAppearance()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: Notification.Name.UIKeyboardWillShow, object: nil)
    }

    deinit {

        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Appearance

    func applyAppearance() {


    }

    // MARK: - Func

    @IBAction func sendMessage() {

        if let text = txtMessage.text, !text.isEmpty {

            let message = Message(text: text, sender: me)
            dataManager.sendMessage(message)
            txtMessage.text = nil
        }
    }

    @objc func keyboardWillAppear(_ notification: Notification) {

        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            bottomTableViewConstraint.constant = keyboardHeight
        }
    }

    @objc func keyboardWillDisappear() {

        bottomTableViewConstraint.constant = 0
    }

    // MARK: - TextField

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        txtMessage.resignFirstResponder()

        return false
    }

    // MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataManager.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell

        let message = dataManager.messages[indexPath.row]

        cell.lblName.text = message.sender.name
        cell.lblText.text = message.text

        return cell
    }

    // MARK: - Data sync

    func dataManagerDidReceiveNewData(_ manager: DataManager) {

        tableView.reloadData()
    }
}

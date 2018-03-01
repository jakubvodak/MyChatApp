//
//  ChatViewController.swift
//  MyChat
//
//  Created by Jakub Vodak on 01/03/2018.
//  Copyright © 2018 Jakub Vodak. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    // MARK: - Data

    var me: User!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = me.name

    }

}

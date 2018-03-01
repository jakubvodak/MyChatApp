//
//  NameViewController.swift
//  MyChat
//
//  Created by Jakub Vodak on 01/03/2018.
//  Copyright © 2018 Jakub Vodak. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet var txtName: UITextField!
    @IBOutlet var btnStart: UIButton!


    // MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()

        checkInput()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


    }

    // MARK: - Function

    @IBAction func startAction() {

        print("Klik")
    }


    @IBAction func akceKlavesnice() {

        checkInput()
    }


    func checkInput() {

        if let text = txtName.text,
                text.count > 2 {

            btnStart.isEnabled = true
        }
        else {

            btnStart.isEnabled = false
        }
    }
}


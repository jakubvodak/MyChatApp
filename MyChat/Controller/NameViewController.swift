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

        applyAppearance()
    }


    // MARK: - Appearance

    func applyAppearance() {

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }

    
    // MARK: - Function

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        txtName.resignFirstResponder()

        if let destination = segue.destination as? ChatViewController,
            let userName = txtName.text {

            let user = User(name: userName)

            destination.me = user
        }
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


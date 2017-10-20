//
//  ViewController.swift
//  BobkovOleg_VKapp
//
//  Created by Олег Бобков on 20.10.17.
//  Copyright © 2017 Олег Бобков. All rights reserved.
//

import UIKit

enum LoginError:Error {
    case wrongUsername
    case wrongPassword
    case wrongUsernameAndPassword
}

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    private let succesfullLoginName = "Oleg"
    private let successfullPassword = "123456"

    override var preferredStatusBarStyle: UIStatusBarStyle { return  .default }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    


    @IBAction func buttonBeenTouched(_ sender: UIButton) {


    guard let username = loginTextField.text else {
    print("login text field is empty")
    return
    }

    guard let password = passwordTextField.text else {
    print("Password text field is empty")
    return
    }

    let result = loginWith(username: username, password: password)

    if result.success {
    print("Successfull login")
    } else {
    print("Failed login")
    if let error = result.error {
    switch error {
    case .wrongUsernameAndPassword : print("Username and password are wrong")
    case .wrongUsername : print("Username is wrong")
    case .wrongPassword : print("Password is wrong")

    }
    }
        }
    }
    private func loginWith(username: String, password: String) -> (success: Bool,error: LoginError?)  {

        if username == succesfullLoginName && password == successfullPassword {
            return (true,nil)
        }

        if username == succesfullLoginName {
            return(false,.wrongPassword)
        }

        if password == successfullPassword {
            return (false,.wrongUsername)
        }

        return (false, .wrongUsernameAndPassword)

    }

}


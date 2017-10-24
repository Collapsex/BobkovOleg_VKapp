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

    @IBOutlet weak var scrollView: UIScrollView!
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

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let login = loginTextField.text!
        let password = passwordTextField.text!
        if login == "Oleg" && password == "123456" {
            return true
        } else {
            let alter = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alter.addAction(action)
            present(alter, animated: true, completion: nil)
            return false
        }
    }
    
    @IBAction func signInButtonBeenTouched(_ sender: Any) {

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
        performSegue(withIdentifier: "showTabbarControllerSegue", sender: nil)
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
            return (true, nil)
        }

        if username == succesfullLoginName {
            return(false, .wrongPassword)
        }

        if password == successfullPassword {
            return (false, .wrongUsername)
        }

        return (false, .wrongUsernameAndPassword)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

}

extension ViewController {
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let keyboardSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func hideKeyboard() {
        scrollView.endEditing(true)
    }
}



//
//  SigninVC.swift
//  OnrampProject
//
//  Created by Bart on 3/5/20.
//

import Foundation
import UIKit

class SigninVC: UITableViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("LoginVC: viewDidLoad()")
        
        signInButton.layer.cornerRadius = 7
    }
    
    // MARK: Check if username and password is valid.
    @IBAction func signInButton(_ sender: Any) {
        if usernameTextField.text == "root" && passwordTextField.text == "root" {
            UserDefaults.standard.set(true, forKey: "isAuth")
            if #available(iOS 13.0, *) {
                Switcher.sceneUpdateRootVC()
            } else {
                Switcher.appDelegateRootVC()
            }
        } else {
            let errorMessage = "Account not found."
            let alert = UIAlertController(title: errorMessage, message: "Please enter these credentials to sign in. (username: root, password: root)", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
}

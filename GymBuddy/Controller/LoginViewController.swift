//
//  LoginViewController.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2019-01-12.
//  Copyright © 2019 ShaonDesign. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.64, blue:1.00, alpha:1.0)
        navigationController?.navigationBar.tintColor = .white

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = NSLocalizedString("Log In", comment: "logga in")
    }
    
    @IBAction func login(sender: UIButton) {
        // Validate the input
        
        let alertTitle = NSLocalizedString("Login Error", comment: "Login Error")
        let alertMessage = NSLocalizedString("Both fields must not be blank", comment: "alertMessage")
        let okMessage = NSLocalizedString("OK", comment: "OK")
        guard let emailAdress = emailTextField.text, emailAdress != "",
            let password = passwordTextField.text, password != "" else {
                let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: okMessage, style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        
        // Perform login by calling Firebase APIs
        Auth.auth().signIn(withEmail: emailAdress, password: password, completion: {(user, error) in
            if let error = error {
                let loginError = NSLocalizedString("Login Error", comment: "Login Error 2")
                let alertController = UIAlertController(title: loginError, message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            // Dissmiss the keyboard
            self.view.endEditing(true)
            
            // Present the main view
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView"){
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

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
        navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:1.00, blue:1.00, alpha:1.0)
        navigationController?.navigationBar.tintColor = .white

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Log In"
//        emailTextField.becomeFirstResponder()
    }
    
    @IBAction func login(sender: UIButton) {
        // Validate the input
        
        guard let emailAdress = emailTextField.text, emailAdress != "",
            let password = passwordTextField.text, password != "" else {
                let alertController = UIAlertController(title: "Login Error", message: "Both fields must not be blank", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        
        // Perform login by calling Firebase APIs
        Auth.auth().signIn(withEmail: emailAdress, password: password, completion: {(user, error) in
            if let error = error {
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
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

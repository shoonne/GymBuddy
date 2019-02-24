//
//  SignUpViewController.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2019-01-13.
//  Copyright © 2019 ShaonDesign. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.64, blue:1.00, alpha:1.0)
        navigationController?.navigationBar.tintColor = .white
        
        self.title =  NSLocalizedString("Sign Up", comment: "Sign Up")
        nameTextField.becomeFirstResponder()
    }
    
    
    @IBAction func registerAccount(sender: UIButton) {
        // Validate the input
        
        let alertTitle = NSLocalizedString("Registraion error", comment: "Registration error")
        let alertMessage = NSLocalizedString("Please make sure you provide your name, email adress and password to complete the registration", comment: "Alert Message ")
        guard let name  = nameTextField.text, name != "",
        let emailAdress = emailTextField.text, emailAdress != "",
            let password = passwordTextField.text, password != "" else {
                let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        
        // Register the user account on Firebase
        Auth.auth().createUser(withEmail: emailAdress, password: password, completion: {(user, error) in
            if let error = error {
                let alertController = UIAlertController(title: alertTitle, message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            // Save the name of the user
            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest(){
                changeRequest.displayName = name
                changeRequest.commitChanges(completion: {(error) in
                    if let error = error {
                        print("Failed to change the display name: \(error.localizedDescription)")
                    }
                })
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

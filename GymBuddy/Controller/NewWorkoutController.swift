//
//  NewWorkoutController.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2018-12-19.
//  Copyright © 2018 ShaonDesign. All rights reserved.
//

import UIKit
import CoreData

class NewWorkoutController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    // Get access to the context in the persistent container and cast as AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // OUTLETS
    @IBOutlet var workoutImageView: UIImageView!
    @IBOutlet var workoutTextField: RoundedTextField! {
        didSet{
            workoutTextField.tag = 1
            workoutTextField.becomeFirstResponder()
            workoutTextField.delegate = self
            
        }
    }
    @IBOutlet var descriptionTextField : RoundedTextField! {
        didSet{
            descriptionTextField.tag = 2
            descriptionTextField.delegate = self
            
        }
    }
    
    @IBOutlet var locationTextField : RoundedTextField! {
        didSet {
            locationTextField.tag = 3
            locationTextField.delegate = self
        }
    }
    
    
    // Create instance of your data model
    var workout : WorkoutMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.64, blue:1.00, alpha:1.0)
        navigationController?.navigationBar.tintColor = .white
    }

    // Add a tag to each text fied, allows to press return to get to the next text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
    
    // Image picker
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photoMessage = NSLocalizedString("Choose your photo source", comment: "Choose your photo source")
        let cameraTitle = NSLocalizedString("Camera", comment: "")
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: "", message:photoMessage , preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: cameraTitle, style: .default, handler: {
                (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            // Alert action with photo library and camera options
            let photoLibrary = NSLocalizedString("Photo library", comment: "Photo library")
            let photoLibraryAction = UIAlertAction(title: photoLibrary, style: .default, handler: {
                (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            // Add action to alert
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            
            present(photoSourceRequestController, animated: true, completion: nil)
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            workoutImageView.image = selectedImage
            workoutImageView.contentMode = .scaleAspectFill
            workoutImageView.clipsToBounds = true
        }
        
        let leadingConstraint = NSLayoutConstraint(item: workoutImageView, attribute: .leading, relatedBy: .equal, toItem: workoutImageView.superview, attribute: .leading, multiplier: 1, constant: 0)
        
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: workoutImageView, attribute: .trailing, relatedBy: .equal, toItem: workoutImageView.superview, attribute: .trailing, multiplier: 1, constant: 0)
        
        trailingConstraint.isActive = true
        
        
        let topContstraint = NSLayoutConstraint(item: workoutImageView, attribute: .top , relatedBy: .equal, toItem: workoutImageView.superview, attribute: .top , multiplier: 1, constant: 0)
        
        topContstraint.isActive = true
        
        
        let bottomConstraint = NSLayoutConstraint(item: workoutImageView, attribute: .bottom, relatedBy: .equal, toItem: workoutImageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    // User pressed the save button
    @IBAction func saveButtonTapped(sender: AnyObject) {
        let alertTitle = NSLocalizedString("Oops", comment: "Oops")
        let alertMessage = NSLocalizedString("We can't proceed because one of the fields is blank. Please note that all fields are required.", comment: "alertMessage")
        // If the fields are empty, show a warning
        if workoutTextField.text == ""{
            
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return
        }
        
        // If the field are filled, create a new WorkoutMO object
        // And initialize it with the current context
        workout = WorkoutMO(context: context)
            
        // Add the text to the data model
        workout.muscleWorkout = workoutTextField.text
        workout.workoutDescription = descriptionTextField.text
        workout.place = locationTextField.text
            
        // Get the image data and add it to the data model
        if let workoutImage = workoutImageView.image {
            workout.workoutImage = workoutImage.pngData()
        }
        // Save the items
        saveItems()
        
        // Dissmiss the view
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindToNewWorkout(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveItems(){
        do {
            // Transfer whats in our context to the data store
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }



}

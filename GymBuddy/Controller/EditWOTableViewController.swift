//
//  EditWOTableViewController.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2019-02-12.
//  Copyright © 2019 ShaonDesign. All rights reserved.
//

import UIKit

class EditWOTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var workout : WorkoutMO!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var textField1 : UITextField!
    @IBOutlet var textField2 : UITextField!
    @IBOutlet var textField3 : UITextField!
    @IBOutlet var imageView  : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.64, blue:1.00, alpha:1.0)
        navigationController?.navigationBar.tintColor = .white
        self.tableView.backgroundColor = UIColor(red:0.00, green:0.64, blue:1.00, alpha:1.0)

        
        // Bort med denna. Vi vill ladda bilden från databasen istället!
        //imageView.image = UIImage(named: "plus")
        
        // Om workout innehåller bild-data så laddar vi bilden:
        if let data = workout.workoutImage {
            imageView.image = UIImage(data: data)
        }
        
        // Vi passar även på att fylla i text-fälten
        textField1.text = workout.muscleWorkout
        textField2.text = workout.workoutDescription
        textField3.text = workout.place
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

   
    
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
            imageView.image = selectedImage
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        }
        
        
        
        let leadingConstraint = NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: imageView.superview, attribute: .leading, multiplier: 1, constant: 0)

        leadingConstraint.isActive = true

        let trailingConstraint = NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: imageView.superview, attribute: .trailing, multiplier: 1, constant: 0)

        trailingConstraint.isActive = true


        let topContstraint = NSLayoutConstraint(item: imageView, attribute: .top , relatedBy: .equal, toItem: imageView.superview, attribute: .top , multiplier: 1, constant: 0)

        topContstraint.isActive = true


        let bottomConstraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: imageView.superview, attribute: .bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        let alertTitle = NSLocalizedString("Oops", comment: "Oops")
        let alertMessage = NSLocalizedString("We can't proceed because one of the fields is blank. Please note that all fields are required.", comment: "alertMessage")
        
        // If the fields are empty, show a warning
        guard
            let muscleWorkout = textField1.text,
            let description = textField2.text,
            let place = textField3.text,
            !name.isEmpty,
            !muscleWorkout.isEmpty,
            !place.isEmpty
            else {
                
                let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(alertAction)
                present(alertController, animated: true, completion: nil)
                
                return
        }
        
        workout.workoutDescription = description
        workout.muscleWorkout = muscleWorkout
        workout.place = place

        
        // Bort med detta, annars så klonar ni objektet och orsakar en himla massa besvär. Vi skickar med workout-objektet från Detail-vyn istället.
        // workout = WorkoutMO(context: context)
        
        // Get the image data and add it to the data model
        if let workoutImage = imageView.image {
            workout.workoutImage = workoutImage.pngData()
        }
        
        // Save the items
        saveItems()
        
        
        // Dissmiss the view
        dismiss(animated: true, completion: nil)
        
        

        
    }
    
    func saveItems(){
        do {
            // Transfer whats in our context to the data store
            try context.save()
            print("Successfully saved")
        } catch {
            print("Error saving context \(error)")
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

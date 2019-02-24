//
//  DetailViewController.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2018-12-19.
//  Copyright © 2018 ShaonDesign. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var headerView: WorkoutDetailViewHeader!
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    weak var workout : WorkoutMO!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.tintColor = .black
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        headerView.workoutMuscleLabel.text = workout.muscleWorkout
        if let workoutImage = workout.workoutImage {
            headerView.headerImageView.image = UIImage(data: workoutImage as Data)
            
        }
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditView",
        let destinationController = segue.destination as? UINavigationController,
            let editController = destinationController.viewControllers.first as? EditWOTableViewController
        {
            print("Success!!")
            editController.workout = workout

        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WorkoutDetailIconTextCell.self), for: indexPath) as! WorkoutDetailIconTextCell
            cell.workoutDescriptionLabel.text = workout.workoutDescription
            cell.selectionStyle = .none
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WorkoutDetailSeperatorCell.self), for: indexPath) as! WorkoutDetailSeperatorCell
            cell.titleLabel.text = NSLocalizedString("WORKOUT LOCATION", comment: "WORKOUT LOCATION")
            cell.selectionStyle = .none
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WorkoutDetailMapCell.self), for: indexPath) as! WorkoutDetailMapCell
            if let place = workout.place {
                cell.configure(location: place)
            }
            return cell
            
            
        default:
            fatalError("failed")
        }
    }
    
    @IBAction func share(sender: AnyObject) {
        
        print(workout.workoutDescription ?? "jej")
        print(workout.place ?? "jej")
        print(workout.muscleWorkout ?? "jej")

    }
    

    
    @IBAction func shareImageButton(_ sender: UIButton){
        // image to share
        let muscleType = workout.muscleWorkout
        let workoutDescription = workout.workoutDescription
        let workoutLocation = workout.place
        
        // set up activity view controller
        var yourArray = [Any]()
        yourArray.append(muscleType!)
        yourArray.append(workoutDescription!)
        yourArray.append(workoutLocation!)
        yourArray.append(workout.workoutImage!)
        let activityViewController = UIActivityViewController(activityItems: yourArray, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func unwindToDetailView(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func save(){
        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    
//    @IBAction func changePicture(){
//        let photoSourceRequestController = UIAlertController(title: "", message:"Choose your photo source" , preferredStyle: .actionSheet)
//
//        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
//            (action) in
//            if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                let imagePicker = UIImagePickerController()
//                imagePicker.delegate = self
//                imagePicker.allowsEditing = false
//                imagePicker.sourceType = .camera
//
//                self.present(imagePicker, animated: true, completion: nil)
//            }
//        })
//
//        // Alert action with photo library and camera options
//        let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: {
//            (action) in
//            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//                let imagePicker = UIImagePickerController()
//                imagePicker.delegate = self
//                imagePicker.allowsEditing = false
//                imagePicker.sourceType = .photoLibrary
//                imagePicker.delegate = self
//
//                self.present(imagePicker, animated: true, completion: nil)
//            }
//        })
//
//        // Add action to alert
//        photoSourceRequestController.addAction(cameraAction)
//        photoSourceRequestController.addAction(photoLibraryAction)
//
//        present(photoSourceRequestController, animated: true, completion: nil)
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//            {
//                workout.workoutImage = selectedImage.pngData()
//                workout.setValue(selectedImage.pngData(), forKey: "workoutImage")
//                self.save()
//                self.tableView.reloadData()
//            }
//
//
//
//            dismiss(animated: true, completion: nil)
//
//
//        }
//
//    }
  
}

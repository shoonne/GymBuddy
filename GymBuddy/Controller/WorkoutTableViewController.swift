//
//  TraingListControllerTableViewController.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2018-12-18.
//  Copyright © 2018 ShaonDesign. All rights reserved.
//

import UIKit
import CoreData

class WorkoutTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Empty view outlet, view to show when there is now items on the list
    @IBOutlet var emptyWorkoutView: UIView!
    
    // Fetch from the store
    var fetchResultController: NSFetchedResultsController<WorkoutMO>!
    
    // Create a object of our data model
    var workouts: [WorkoutMO] = []
    
    // Create a search controller
    var searchController : UISearchController!
    var searchResults: [WorkoutMO] = []
    
    // Get access to the context in the persistent container and cast as AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Appearance of the navigation bar
        navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.64, blue:1.00, alpha:1.0)
        navigationController?.navigationBar.tintColor = .white
        tabBarController?.navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:1.00, blue:1.00, alpha:1.0)

        
        // Search
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = false
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        
        // Fetch the data from the Data model
        let fetchRequest: NSFetchRequest<WorkoutMO> = WorkoutMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self

            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    workouts = fetchedObjects
                }
            } catch {
                print(error)
            }
        
        
        // Prepare the empty list view
        tableView.backgroundView = emptyWorkoutView
        tableView.backgroundView?.isHidden = true

    }
    
    // Update tableview
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    // Store functions to manage the data
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            workouts = fetchedObjects as! [WorkoutMO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // MARK: - Search
    func filterContent(for searchText: String) {
        searchResults = workouts.filter({ (workout) -> Bool in
            if let name = workout.muscleWorkout{
                // Check to see if it containts the text from the search
                let isMatch = name.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }

            // Otherwise return false
            return false
        })
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        if workouts.count > 0 {
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .singleLine
        } else {
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // If the searchbar is active, show the results, else just show the all the data
        if searchController.isActive {
            return searchResults.count
        } else {
            return workouts.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WorkoutTableViewCell
        
        // If we get the workout from the search result or the orignal array
        let workout = (searchController.isActive) ? searchResults[indexPath.row] : workouts[indexPath.row]
        
        // Configure the cell
        cell.workoutLabel.text = workout.muscleWorkout
        if let workoutImage = workout.workoutImage {
            cell.thumbnailImageView.image = UIImage(data: workoutImage as Data)
        } else {
            cell.thumbnailImageView.image = UIImage(named: "workout")
        }
        return cell
    }
    
    // MARK: - Right Swipe
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteTitle = NSLocalizedString("Delete", comment: "Delete")
        
        // Add swipe to edit to delete the items
        let deleteSwipe = UIContextualAction(style: .destructive, title: deleteTitle) {
            (action, sourceView, completionHandler) in
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(restaurantToDelete)
                appDelegate.saveContext()
            }
            completionHandler(true)
        }
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteSwipe])
        
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") {
            (action, sourceView, completionHandler) in
            
            // image to share
            let muscleType = self.workouts[indexPath.row].muscleWorkout
            let workoutDescription = self.workouts[indexPath.row].workoutDescription
            let workoutLocation = self.workouts[indexPath.row].place
            
            // set up activity view controller
            var yourArray = [Any]()
            yourArray.append(muscleType!)
            yourArray.append(workoutDescription!)
            yourArray.append(workoutLocation!)
            yourArray.append(self.workouts[indexPath.row].workoutImage!)
            let activityViewController = UIActivityViewController(activityItems: yourArray, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            
            // exclude some activity types from the list (optional)
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
            
            completionHandler(true)
        }
        
        shareAction.backgroundColor = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
    
        let shareSwipe = UISwipeActionsConfiguration(actions: [shareAction])
        
        return shareSwipe
    }
    
    
    
    

    
   
    // Pass data to the new segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailView" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailViewController
                destinationController.workout = (searchController.isActive) ? searchResults[indexPath.row] : workouts[indexPath.row]

            }
        }
    }
    
    // Unwind action to dismiss the view
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    //C IN CRUD SAVE THE DATA TO THE MODEL
    func saveItems(){
        do{
            // Transfer whats in our context to the data store
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        // Reload the tableview to show the new data
        self.tableView.reloadData()
    }
 



}


// MARK: - Add a swipe to edit button to edit text fields

//        let title = NSLocalizedString("Edit your workout", comment: "Edit workout")
//        let message = NSLocalizedString("", comment: "message")
//        let itemTitle = NSLocalizedString("Edit item", comment: "Edit item")
//        let editSwipe = UIContextualAction(style: .normal, title: title) {
//            (action, sourceView, completionHandler) in

// Create an alert controller
//            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
// Create an action for the alert controller
//            let editAction = UIAlertAction(title: itemTitle, style: .default) { (action) in
//
//                // Check to see if the fields are empty before we save it to our data model
//
//                if muscleWorkoutTextField.text == "" {
//                    return
//                } else {
//                    self.workouts[indexPath.row].setValue(muscleWorkoutTextField.text, forKey: "muscleWorkout")
//                }
//
//                if workoutDescriptionTextField.text == "" {
//                    return
//                } else {
//                    self.workouts[indexPath.row].setValue(workoutDescriptionTextField.text, forKey: "workoutDescription")
//                }
//
//                if workoutLocationTextField.text == "" {
//                    return
//                } else {
//                self.workouts[indexPath.row].setValue(workoutLocationTextField.text, forKey: "place")
//                }
//            }



//            let placeHolder1 = NSLocalizedString("Edit muscle group", comment: "Edit muscle group")
//            let placeHolder2 = NSLocalizedString("Edit workout description", comment: "Edit workout description")
//            let placeHolder3 = NSLocalizedString("Edit workout location", comment: "Edit workout location")
//
//            // MARK: - Add textfields to the alert
//            alert.addTextField { (textField1) in
//                textField1.placeholder = placeHolder1
//                muscleWorkoutTextField = textField1
//            }
//            alert.addTextField { (textField2) in
//                textField2.placeholder = placeHolder2
//                workoutDescriptionTextField = textField2
//            }
//            alert.addTextField { (textField3) in
//                textField3.placeholder = placeHolder3
//                workoutLocationTextField = textField3
//            }
//
//            // Add the actions to the alert controller
////            alert.addAction(editAction)
//            // Present it to the user
//            self.present(alert, animated: true, completion: nil)
//
//            completionHandler(true)
//
//        }

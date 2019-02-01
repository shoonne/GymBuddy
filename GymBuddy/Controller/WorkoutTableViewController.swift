//
//  TraingListControllerTableViewController.swift
//  GymBuddy
//
//  Created by shaon ahmed on 2018-12-18.
//  Copyright © 2018 ShaonDesign. All rights reserved.
//

import UIKit
import CoreData

class WorkoutTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    // Empty view outlet
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
        
        navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:1.00, blue:1.00, alpha:1.0)
        navigationController?.navigationBar.tintColor = .white

        
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
    
    // Delete a item from the list
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        // Create a text field to store the users input
        var muscleWorkoutTextField = UITextField()
        var workoutDescriptionTextField = UITextField()
        var workoutLocationTextField = UITextField()
        
        
        // Delete an item from the list by swiping
        let deleteSwipe = UIContextualAction(style: .destructive, title: "Delete") {
            (action, sourceView, completionHandler) in
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(restaurantToDelete)
                appDelegate.saveContext()
            }
            completionHandler(true)
        }
        
        // Add a swipe to edit button
        let editSwipe = UIContextualAction(style: .normal, title: "Edit your workout") {
            (action, sourceView, completionHandler) in
            
            // Create an alert controller
            let alert = UIAlertController(title: "Edit your workout", message: "", preferredStyle: .alert)
            // Create an action for the alert controller
            let editAction = UIAlertAction(title: "Edit Item", style: .default) { (action) in
    
                // Check to see if the fields are empty before we save it to our data model
                
                if muscleWorkoutTextField.text == "" {
                    return
                } else {
                    self.workouts[indexPath.row].setValue(muscleWorkoutTextField.text, forKey: "muscleWorkout")
                }
                
                if workoutDescriptionTextField.text == "" {
                    return
                } else {
                    self.workouts[indexPath.row].setValue(workoutDescriptionTextField.text, forKey: "workoutDescription")
                }
                
                if workoutLocationTextField.text == "" {
                    return
                } else {
                self.workouts[indexPath.row].setValue(workoutLocationTextField.text, forKey: "place")
                }
            }
            
            // Add textfields to the alert
            alert.addTextField { (textField1) in
                textField1.placeholder = "Edit muscle group"
                muscleWorkoutTextField = textField1
            }
            alert.addTextField { (textField2) in
                textField2.placeholder = "Edit workout description"
                workoutDescriptionTextField = textField2
            }
            alert.addTextField { (textField3) in
                textField3.placeholder = "Edit workout location"
                workoutLocationTextField = textField3
            }
            
            
            // Add the action to the alert controller
            alert.addAction(editAction)
            // Present it to the user
            self.present(alert, animated: true, completion: nil)

            completionHandler(true)
            
        }
        
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteSwipe, editSwipe])
        
        return swipeConfiguration
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
